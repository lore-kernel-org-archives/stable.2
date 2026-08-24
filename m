Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0935CB91;
	Mon, 24 Aug 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575324; cv=none; b=htPHYYa866zzjhJfgYq8kmBHGVVrcNkgqwPiFPWEZVB5/Wm5TZnh31/LyYvUz1HJphx7g2l8181iL2YpeE5YGNxV2b/g4OlLgrXni7j0qFrsOPpqQEyyhnIubw1cny38R2ZUz/xmafbVwabhNzgyA8MCPPlRBEf8M/LP9PhR4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575324; c=relaxed/simple;
	bh=UmuseKvcI+SWBhzEipWmfvar25ab4brFYoBPHMCnm+Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=X2izlAzJZCmKU8frhRr65OaaZ/FzMfOtSOEEsjbHsH1J8xpDrMiOLjsfunU8q2WytI+L/kIhTmz5LsWXahgw9TNCmyJ3wVn/7sVrUQko6wHZ5Fo21Aoop+OhywBiuNCFssutmlTXC4gKZvU2bT0X32uXQr19gOuwFxiJ0dJcUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oD+9+p2B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mn0vUfbn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GM84VEdr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I/BeLCnz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oD+9+p2B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mn0vUfbn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GM84VEdr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I/BeLCnz"
Received: from localhost.localdomain (unknown [IPv6:2a07:de40:b2bf:1b::12ef])
	by smtp-out2.suse.de (Postfix) with ESMTP id 026281F766;
	Mon, 24 Aug 2026 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787575314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VIDgs8iAZXEVKDlswAXyXwdUD7ShHc7/MjvIWDD2YA=;
	b=oD+9+p2BK7Rdg1taWyf8v4/ClHfafGxpRSRNL/7ldwX5TXVOSO0VzbvABUcLaKQ2uBS3OI
	irYewdFEbW4qRne9hY1URgm9+s/LSRpFPtaIS52aUtomgEHm3dzE05RGfECz4FJLmotIfS
	K3aSR2+VQ3J/grCmnGAhVAa5eIXtsuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787575314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VIDgs8iAZXEVKDlswAXyXwdUD7ShHc7/MjvIWDD2YA=;
	b=mn0vUfbnsPUGjFkXiis0kmFhzjfGg4NsMzJ2ASU1ZzAixQ1dDAR7oA4JYFM4K1huHMfvGj
	46oJBBbQQJFFQwCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GM84VEdr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="I/BeLCnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787575310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VIDgs8iAZXEVKDlswAXyXwdUD7ShHc7/MjvIWDD2YA=;
	b=GM84VEdr7RypoTMe4QNs8pQVc0RrlV7+j3zhXjKi0Cdk9wD9HmkLS4y7ul1h0Mo8UoZ0qw
	cuLsYkYe0OGGTGB9i4wnQIuxgpendCZDnKQSwuQ3aFhMa7I8nAJ91g6ip/9G2pvOjXiA7F
	V+DwnsdXeBs3b4CtcpnEJFdVDxiO5q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787575310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VIDgs8iAZXEVKDlswAXyXwdUD7ShHc7/MjvIWDD2YA=;
	b=I/BeLCnztAV4lyCfHU+qrIsiq6T1r0DEVYvjy0GGYoSoN+zyafwPo08MlUjwMd6x0v6ab/
	igvUdwK0jZHiurDA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/livepatch: update
 test-ftrace.sh for deprecated ftrace_enabled
From: Miroslav Benes <mbenes@suse.cz>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, rostedt@goodmis.org, mbenes@suse.cz, 
 jolsa@kernel.org, mhiramat@kernel.org, jpoimboe@kernel.org, 
 joe.lawrence@redhat.com, mark.rutland@arm.com, corbet@lwn.net, 
 stable@vger.kernel.org, linux-open-source@crowdstrike.com
In-Reply-To: <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
References: <20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com>
 <20260806153000.4184871-3-andrey.grodzovsky@crowdstrike.com>
Date: Mon, 24 Aug 2026 14:41:48 +0200
Message-Id: <178757530845.29054.17849856818444710672.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=577; i=mbenes@suse.cz;
 h=from:subject:message-id; bh=UmuseKvcI+SWBhzEipWmfvar25ab4brFYoBPHMCnm+Y=;
 b=owGbwMvMwMHYWJt9x2W1tA7jabUkhqweG15Fqdww1+1eRgsXu7K+Vlz68dCt079yXv0XiNCen
 ba/IiOyk9GfhYGRg8FSTJHl9V5nOcMpuQaa1e/uwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjhEDF6cATDWXNPv/oF32ra2KymZH/KepzFNm5v19SV3LcUm2/faQ15zWknYOq+PqeO6V3FW
 5NFtGzGtHpdkfFYNf73LvpVTpel3OrJp6mG3N8dMqwVtW9Na6/zrMLWy6IpS/1TliQmlnVdeTtU
 FJAVll71rvWOfsK6zePO3Oi3nLdC51ZPX8N5adcP6cblLLxRrXYhFfw1ecb6brXX/NFjl99Trz/
 3PFUz1YnGQc2T79aZj6tUjR//ans5OjEi7vdL579K3z/YWnt1ptXNZS5el7bmqDkYB9yZsq18/r
 Ajb2L97Eb6Fz2039p0nOs79iGlYpqRf/Vs7T8HsheU8x5uebNbfXLAo5kn9x05ZDs/6yiLMYXjj
 7OLsGAA==
X-Developer-Key: i=mbenes@suse.cz; a=openpgp;
 fpr=91BB0699882EF39D46654BB3FF98A38DA80834DA
X-Spamd-Result: default: False [17.41 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	HFILTER_HELO_5(3.00)[localhost.localdomain];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	BAYES_HAM(-2.98)[99.90%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1b::12ef:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	DIRECT_TO_MX(0.00)[b4 0.17-dev];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::12ef:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,localhost.localdomain:helo,crowdstrike.com:email]
X-Spam-Score: 17.41
X-Spam-Level: *****************
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: 026281F766
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: YES
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, 06 Aug 2026 11:30:00 -0400, Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> kernel.ftrace_enabled=0 is now refused on kernels that deprecate the
> knob, so the old disable/reload flow no longer applies there. Probe
> for this with ftrace_disable_supported() and keep the full original
> scenario (disable, fail to load a livepatch, re-enable, load, confirm
> disable is refused while loaded) on kernels where it still works;
> otherwise just confirm the write is refused.
> 
> [...]

Acked-by: Miroslav Benes <mbenes@suse.cz>

-- 
Miroslav

