Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C193F4106;
	Mon, 24 Aug 2026 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574621; cv=none; b=m8BvbSyg3wgqd9OvqoH01FtwuDWtT+4YZlSRbdH5wWKLZuSaBk10JDcm77by+lAY/FnzUUqieJKvI4wLEgJ2pHrRx910I7FyZjR8w1Ya+jPADnzVpYXNgiFt//5BZt3FHxbTZ4IhSM56E5HaIAy3iT3sCdO2XbagKRDnRM+jBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574621; c=relaxed/simple;
	bh=4FYgbXV1GvF2U0TPr00VPqUvtdejrIO8XnW0SMV09cY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=igXzl74s2WGZqqX8fXpF+c3gjxgJL44KTk06Bj+xqA0WUbW41uezf2teIbRIngo1kfpTLW4UTzl2BQMWz4oBDVJSZyzs0ckjaZ6V3b8cWGYH9gHSzdSc/Kon57bhaAjVXIEIUhMK+GCa0CtRJ1t55IEivuYofXRNHkUq4GvRYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s8OmJWQA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3w9y/Udb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hrqUWpxJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wQDHiOzw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s8OmJWQA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3w9y/Udb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hrqUWpxJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wQDHiOzw"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 77B1D1F456;
	Mon, 24 Aug 2026 12:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787574612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TxHLB2ACRy0YXvBC2+vJNSimCPx49N4FXYU/nbyQLk=;
	b=s8OmJWQA/+fx5Tg26/JBeMUaEvaCxzqEDnXVeh4sDnf2WDUElyX6zl6xy28oIRa9lRFe7h
	MjvLs5YLEVSu24jlufgXcRMxMMTXwBMRP6BFbpve7yrKokmVthfC6CXcRJALRHRVpNH0Ck
	LqGVculcKtQQmO1syvZEhlJ0olF3Xn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787574612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TxHLB2ACRy0YXvBC2+vJNSimCPx49N4FXYU/nbyQLk=;
	b=3w9y/UdbLBGYBX1XIy3lUChaSdi0SzspnjZQeB/IyYSehbQxGw/dVwWUISLR7+1BNo20HJ
	HO6Sr31Kap2B/UDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hrqUWpxJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wQDHiOzw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787574608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TxHLB2ACRy0YXvBC2+vJNSimCPx49N4FXYU/nbyQLk=;
	b=hrqUWpxJfZN0QQCjdA0oiDu0222d4nwXyumUbNdH5G+Nm+mcx9hMq87JZFQ2FTICKamHWR
	8+My9FSPUOl3/YRZu5e3e4Cb7KVnx4y7N8l7tBhzvKQ2Vl957M2scpIXmdP6LE0jEL5+jT
	rgd6dKTevV8svVzZ6jpbpRwu1xzsAY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787574608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TxHLB2ACRy0YXvBC2+vJNSimCPx49N4FXYU/nbyQLk=;
	b=wQDHiOzwdGwAAGbXNtUr11IgHGTLML+ZTgybkSYzTVxKRs3vq9IMLbEGrSvxeJ/ljC+BuP
	Us+utJ17UGPll7CQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH bpf-next v3 1/2] ftrace: deprecate disabling via
 ftrace_enabled sysctl
From: Miroslav Benes <mbenes@suse.cz>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz, 
 jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
 joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
 stable@vger.kernel.org, linux-open-source@crowdstrike.com
In-Reply-To: <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-2-andrey.grodzovsky@crowdstrike.com>
Date: Mon, 24 Aug 2026 14:30:06 +0200
Message-Id: <178757460647.29054.9328797950595292140.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=546; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=4FYgbXV1GvF2U0TPr00VPqUvtdejrIO8XnW0SMV09cY=;
 b=kA0DAAgBgX1r3ESrGywByyZiAGqMOVCg3dLuIU/b+lZ79aZUVBHhJAnKnzjEOtRa15DeUEB8i
 4kBTwQAAQgAORYhBOu9Qx4xlG0wKXvu3YF9a9xEqxssBQJqjDlQGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjEyLDIsMgAKCRCBfWvcRKsbLGuoCACbLxUEN77+CiHSPWNHC8OQFNVBbN/QhaER1SBsFM6
 nETmCAbItEcvZVPq3jYxYDSwMyKRoNRfOFFfkyEklj0k0IZaJ8guQWfqm1BPmGKRaCO4R3E2Jnl
 +rrtyCSkGBqnRml1OwlgqEHFcKQSV8yjN8yjvNYrfD3sFL2zYMQKsOmAAUbji3WoaoLjmBGM4LF
 ORl/iswkEHZlkS/21qM/LuvRgdAAN7l4weyzUvu15q7mJJMhSvTT3HM9yriKd1D8uC+HkU4uwF6
 svWQYhWI7Wjb7WzDq1cxrvjG8dLzv3roaYoBwJUOBHIYroL7LyKZ10QZbx2gWWG7qQEtgvRalRV j
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [17.40 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[0.999];
	BAYES_HAM(-2.99)[99.96%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crowdstrike.com:email,suse.cz:email,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: 17.40
X-Spam-Level: *****************
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 77B1D1F456
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 06 Aug 2026 11:29:59 -0400, Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> Writing 0 to kernel.ftrace_enabled has not reliably disabled ftrace
> for years (FTRACE_OPS_FL_PERMANENT users already block it, and more
> callers rely on ftrace always being on). Refuse the write instead of
> leaving it in an inconsistent "disables some, not all" state: return
> -EOPNOTSUPP and log a message. Reads and enabling (writing 1) are
> unaffected.
> 
> [...]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

