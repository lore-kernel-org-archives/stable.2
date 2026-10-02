Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E193ED5C7;
	Fri,  2 Oct 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929807; cv=none; b=uKChXp3NlaixzSOvxdnqla2Q5qCKy7heFALbe0GQWPkT3rKFXhGvN3+WLbUhs+oGvDFlbnrJCyzExRM/uGmB0Gm27Cwy/JwsB56fWLC0zwdzc1jNJIdi9LeYXvWXT7Z42p36a7nXW0yMUKnR8Fw9e10McoT3w2H6ujVV5d+5dOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929807; c=relaxed/simple;
	bh=r5xrmLLhj+fqsNOcxayfQVjvv5VfqaM22Dh/naaYh6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFfji3yyZmv2cS2lMU3AsA7haejdoLi7b0cq26+iBk/0fny0cjP0zwiOvQ88Ua67Yo+umA7NE/Rx8HY1DPxFIl6j79+2SX9tTuoiX/T8s9mykb2SneMz9ZJ2PPKqv1Zy3bQDkW6tjOG68MnkPQhb4qrDtSYXlrnZtaGw8TZ3LUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPOhOlXh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPOhOlXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DC61F000FF;
	Fri,  2 Oct 2026 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790929805;
	bh=88FBSlp/h8YRF3ZNOj+jUhuadHqBOuspdw4hwquDi1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZPOhOlXhmVIrkdBOnsKsWxPe5RWsPKZ/b+MFu9PHTiV91nTs9P9Wbg+gFuBqa0T3q
	 wMK6vY6QhCLV8QaIHlABd60MpsVS1E80TmGbsyJJFWVUWCOm7iMW/RAAGpTuEfJ3PA
	 IcTizFsWXmKBnIOg5qJ99kKt4qndEW42kktsB9as=
Date: Fri, 2 Oct 2026 10:30:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: tjdqudcks0424@naver.com
Cc: bsingharora@gmail.com, xu.xin@linux.dev, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] taskstats: route exit listener records through their
 netns
Message-ID: <2026100208-pucker-conduit-6da7@gregkh>
References: <20261002075842.146026-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002075842.146026-1-tjdqudcks0424@naver.com>

On Fri, Oct 02, 2026 at 04:58:42PM +0900, tjdqudcks0424@naver.com wrote:
> From: 성병찬 <tjdqudcks0424@naver.com>
> 
> Commit edc73c7261ca ("kernel: make taskstats available from all net
> namespaces") made the taskstats Generic Netlink family available from all
> network namespaces.  CPU-mask listener registrations, however,
> still store only a bare netlink port ID in a global per-CPU list and send
> exit records through init_net.
> 
> Netlink port IDs are namespace-local.  An administrator can register an
> exit listener after unsharing only the network namespace, while an
> unprivileged init_net socket binds the same numeric port ID.  The latter
> then receives taskstats for exiting tasks of other UIDs despite being
> unable to register a listener or issue a direct taskstats query.
> 
> Do not address this by rejecting listeners outside init_net.  That was
> the v1 approach.  No confirmed deployment relying on this combination
> was found, but taskstats has accepted the documented CPU-mask listener
> command there since v5.19 and in-tree tools use this interface.  Preserve
> that behavior to avoid an unnecessary compatibility risk.

As this is the first public version of the patch, there's no need to
talk about a v1 here, it just confuses everyone involved.

> Associate each listener with taskstats family-private storage for the
> exact Generic Netlink socket.  Record that socket's network namespace and
> port ID and use both for unicast.  On socket release, the family-private
> destructor removes every listener owned by that socket.  The socket pins
> its namespace until the destructor returns, so no additional net
> reference is needed.
> 
> The per-CPU rwsem protects the listener-to-owner pointer from registration
> through unicast and removal.  It also makes explicit deregistration,
> failed-send cleanup, and socket destruction mutually safe.  Allocate a
> complete multi-CPU registration batch before publishing it so an
> allocation failure neither leaves a partial registration nor removes an
> older one.
> 
> A purpose-built reproducer found and validated the issue in disposable
> QEMU guests.  On the unmodified kernel, the child listener missed the
> record and the colliding init_net socket received it.  In three fixed
> runs, the child listener received the record, the colliding socket timed
> out, and its direct query and registration returned EPERM.  Init-net and
> child-net listeners, PID/TGID queries, deregistration, same-port listeners
> in two child netns, close and netns teardown races, KASAN, UBSAN, lockdep,
> listener counts, and kmemleak also passed.
> 
> The per-socket Generic Netlink API exists in v6.8 and later.  Older stable
> trees affected by the Fixes commit need a tailored backport.
> 
> Fixes: edc73c7261ca ("kernel: make taskstats available from all net namespaces")
> Cc: stable@vger.kernel.org # 6.8+
> Link: https://lore.kernel.org/all/20110630120831.GB7707@albatros/
> Link: https://lore.kernel.org/all/87v8x678ph.fsf@email.froward.int.ebiederm.org/
> Assisted-by: OpenAI Codex
> Signed-off-by: 성병찬 <tjdqudcks0424@naver.com>
> ---
> Changes in v2:
> - Preserve CPU-mask listener registration in non-initial network
>   namespaces.
> - Associate listeners with their registration network namespace.
> - Deliver exit records through the listener's namespace.
> - Handle listener cleanup across deregistration, socket close, and
>   network namespace teardown.
> - Add the requested Assisted-by trailer.
> - Add cross-netns collision and teardown A/B test results.
> 
> v1: https://lore.kernel.org/r/20261001223721.458667-2-tjdqudcks0424@naver.com
> 
> kernel/taskstats.c | 135 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 91 insertions(+), 44 deletions(-)

This is a lot of change, is there a selftest to verify this all still
works properly somewhere?  How did you test it?

thanks,

greg k-h
