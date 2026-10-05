Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2941F48FF86
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208577; cv=none; b=S1CTpa0sGkwcZwubn7HT3TK1UAwg93zC31HMMG45W5/1Z59TWim+egyuJjqsQkWG3WxJboQCuXTKFPy6j0S0pqi6eSN0dXvj43Vcsht6NV4fzwDdIwt2JVcxF9TtV1Wi2X5Zsd3+maP9OHulitsEj6f1I5VPjxa6Ds+wK5pBePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208577; c=relaxed/simple;
	bh=JWfho7a4h/v5oQQXy2nREW5kZhZQo+AC4rzMKRV9ezE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2KfLIb6Fhv8g6j7g37KAeLcOBgndCFITxzTTl0LP3weIYDWWOu2GSYh1zUS6MIfaU9T02DN1McJgQpEF4ZLE/H+ceDvwADgIb4324EERtbT4ZIvN68yLz0FuodpjToROOtPWj3fQz6T1f1GsZca3uliEAO3IDmixwqqBVDnowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUvAKb9q; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUvAKb9q"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso6454985ad.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791208574; x=1791813374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcYeOPC3IkRIRj437rPzllUvmUYP5WaI0NjLayKQU9w=;
        b=bUvAKb9qWJf3x0ZiWWua3QhGMwTLzAefTM+Myzxv3RFPO/TiAhdPnC1YMQlO9RJS7z
         9Fh2ABAhdio11y6ghLkRuCelEngki3puIC9b6mFWe/ynjjo+0JK2QqXppYCgm4GBK52r
         tFmioN1uis37WuJ+J2CRDaUQOaKmQgexvrWxeTgp5EXY5GdBi2fZ0wrkMg7pi75s21Ep
         B2r58TVpTIVaC3b4j2OzBShg5W1N/dyaCfN09l8cnR5QkVlqBwzbKBY6atvY+PjoKmdP
         Btz3uEvKcQYN1kqtx6u1Vr7YgYzq51k1Yh7cZjTm36RKUcQwl8+Z9N3ynrbNtSa10PMp
         PRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208574; x=1791813374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcYeOPC3IkRIRj437rPzllUvmUYP5WaI0NjLayKQU9w=;
        b=vHJy990K+1nJ6+zJ55PKsUm/nD4l9IwdMHHFa2bxgZtuTeCuugI6CoRVSmZ6vqKBX3
         4lPhk1efinQJK5bgq02deLbX31jQVuEzJYJbud6C9K6eHF4S71PmlpUX4Np+WI3I8TfS
         6bFi3OPr27laNVEtkqRyHQ6lUe2hNHpzPmwDKDgejyEk3fjP4PO1iP62asAQARTCIkG9
         +MWRI0Q2tRZWDmWkRk35iLpEsvD6ww5ewLE+hHjTZuVqO9Y98SOMbUk3MAjUCIB2GQ/w
         aab+vYuR9dWcq/j3uPX+Du8ZZxIVbiWSpIx2rELlLf+S9YQMA1VaTkCQebDjBZ6OYlrj
         jWyw==
X-Forwarded-Encrypted: i=1; AKwUvBx298+ew+Z/QsnQ0bmKh3A5gdhI74Yj5hxnEQgUg8XAHIrT0dX89MGqUb4ol9yMKjeltT7kyQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKfbdV0Ebc2kabjfyORMvIpcBFaCl5AoRwEGOT60J/4uCy4SCZ
	9eWfpaNcU/NycCMI1VraRv0CJeCSdBBUGwbwa52fzavoB1HgI6LPELySlQoWYQ==
X-Gm-Gg: AYBFou1haLXf/T8NP2LHVmy6WcsjBcgurTV6JwSWUXTWY4YYVlg3xnm9HkJb8VLGFNs
	2ffM26uvzvZ/i2FJIgK7ZmzS1Z76BN1y5mF0SHJX9+AXKZ3bYTNGbyNJrSrbgnDkWUn3aZi+4c9
	SQGx38xMRG1obSD441cZmpmp9Zw37eRfQLdzJkYXlWbWfTE15NhsLiSduSWoSb3om3ArkIiFn9/
	Tgq+MFvXNIkgGVdbgzS+SQVrcIEvewXpt+4250quu6htgf/ZBpygX0vp3a3vRYeQMkmlGlPiw+p
	n6Hu5Fio2T69TKU00BmTkO08WTNREubMqh+JN4oCrPy/r8zZoWl9+jOEXPUTonH06GYwY3EglBf
	k2Ij6SbatGCJFi4nOCOeJvWfy/WYP74EKRmBZQA7gOCbvDUIU1vtKiZX5vXarOhmLc4pw2XnK5O
	CLhdlN85s1Id9zqCQ1jBzm6tedgeyIkaeYI9thXy/qiRsAtLvrw2ADnir1IZEiE9Sx1YG7C89l+
	5xm3I9ghUdC7kfKDYI/JKT3RRf3
X-Received: by 2002:a17:902:da4b:b0:2dd:c100:7cb8 with SMTP id d9443c01a7336-2e49b6d0041mr92256255ad.52.1791208573773;
        Mon, 05 Oct 2026 06:56:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a55b65a7sm7960905ad.12.2026.10.05.06.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:56:13 -0700 (PDT)
Date: Mon, 5 Oct 2026 22:56:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v3] strparser: make sure __strp_recv isn't running
 before tearing down the parser
Message-ID: <asOseirrkC5YC6qf@v4bel>
References: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>

On Mon, Oct 05, 2026 at 03:50:02PM +0200, Sabrina Dubroca wrote:
> The comment above strp_done() claims that if strp is stopped,
> strp_recv will no longer be called. That's only true if the caller has
> a mechanism (eg locking) to guarantee that strp_recv() calls that
> started before strp_stop() have completed by the time we call
> strp_done().
> 
> This adds a dummy lock_sock/release_sock pair to guarantee that any
> in-flight strp_recv() (which runs under either bh_lock_sock or
> lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> has completed.
> 
> Only espintcp can be affected by this race condition, but this patch
> makes sure no future user of strp can have the bug.
> 
> This could crash on strp->sk ("general mode" of strp), but this mode
> has been here for 9 years and has never been used. It'll be gone soon,
> no point worrying about it.
> 
> Switch the stopped/paused/etc bits to u8's to avoid races between
> strp_stop() and strp_pause/unpause().
> 
> A reproducer has been published and turns the possible UAF into an
> exploit [1].

:(

> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Link: https://lore.kernel.org/all/aZLn2Faeg1FB7XOf@v4bel/
> Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
> Link: https://github.com/m0x41nos/RustyTux [1]
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Hyunwoo Kim <imv4bel@gmail.com>
