Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A10559C80;
	Tue, 29 Sep 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710191; cv=none; b=g8cDf4wTt06v97Zd1nh+kplJWdMl32UpCenqJaCulYQTebH5t2QkVkob/d7VE7olDUadXS8pCN+zh/Akg4aOzXxmPMSKdxYCYlQzxnHaXHAjSSAlUOrKNRuL852ueNXcub0aSoA1xNNQcBaYNrXzvAQbzFggJFjWw7Y6fNMKsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710191; c=relaxed/simple;
	bh=XT3TtzDfYVYwNGPJXP2iM16a0w68evK/j8Vxe5hGtsw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LiENuQRBvaSzjOaOj+xEF9utfYzaqFevjJ7X/XwsHJvXm0H8FOKZ3PzZU4ZBviJR/WOhdNNuqjD871smwqwnQ0dMidqdYChn+1sLBzZj2yA1O3J2aLWzmPaBohBKJmj8AwEMJAwnA2QyjKbYmqR+j7/sgGBaUOWGyh7vCF9QeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfC3r0Js; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfC3r0Js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5701F00893;
	Tue, 29 Sep 2026 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710188;
	bh=eeOIipdTgDA3ymgH0ud1FeNe/wu8MtjBi/zdPv1rws0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OfC3r0JsrsbeDooTbPzt9oUxW3NfMTo7GGZTl7XZoQvgq3zLPV61xnZAi582yp/1Q
	 KlYKO5wAfI/B1lCnjzKzpgb8hRfXQc5DjZZRUDx8w4ZWhqQ/0gpvSz2Kp0F9kqbz0d
	 LYDrhwR0vfmaQkmGWHMLHBkgo/BkKb9EJQa5cv+e9QIdjaf1IlOnK2fJ/VWNL/7YpC
	 dPE7V1XHuyy0HJ9DXL/fJ7H/lth5Q9qb6RNGZHERxg7FFNe1RDXVk/C3k4waaB4aKu
	 8p+WD6BsIT9uxov8MhAP/TWkr5cCbvaxZkLvBTLtG5zJ8198zjdWg2beOQRsKkMFwu
	 as6Z3VpqplPSQ==
Subject:
 Re: [PATCH net 1/2] rxrpc: Fix the comments saying RFC8958 to be RFC8985
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Tue, 29 Sep 2026 19:29:46 +0000
Message-ID: <179071018682.434549.14159424380322602012@kernel.org>
In-Reply-To: <20260925191520.2206700-2-dhowells@redhat.com>
References: <20260925191520.2206700-2-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "rxrpc: Fix the comments saying RFC8958 to be RFC8985"
  only changes comments.

--

rxrpc: Fix the comments saying RFC8958 to be RFC8985

This commit fixes comments in net/rxrpc/input_rack.c and
net/rxrpc/ar-internal.h that cited RFC8958 when they meant RFC8985, the
RACK-TLP loss detection algorithm for TCP. Only comments change. The
compiled output is the same.

> Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
> Signed-off-by: David Howells <dhowells@redhat.com>

[ ... ]

> cc: linux-afs@lists.infradead.org
> cc: stable@vger.kernel.org

[Severity: Low]
This isn't a bug, but should the stable Cc be here?

Each hunk swaps RFC8958 for RFC8985 in a comment, for example the file
header in input_rack.c:

-/* RACK-TLP [RFC8958] Implementation
+/* RACK-TLP [RFC8985] Implementation

Documentation/process/stable-kernel-rules.rst says:

  - No "trivial" fixes without benefit for users (spelling changes, whitespace
    cleanups, etc).

The Cc also doesn't seem needed as a prerequisite for the next patch in
the series, "rxrpc: Fix RACK-TLP implementation". That patch's hunks and
context lines don't touch any of the comments edited here. It changes
rxrpc_rack_mark_lost(), the bodies of rxrpc_rack_update_reo_wnd(),
rxrpc_rack_detect_loss() and rxrpc_tlp_calc_pto(), and the struct fields
under the "RACK-TLP [RFC8985] state" comment, which was already correct.
The functional fix should therefore apply cleanly without this patch.

Could the stable Cc be dropped, and would this patch fit better in
net-next than in net?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com
