Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329501;
	b=mSYMNYdEumBdO4bVYfbPlMp8Xq4Y4vTwkSzZ7IhJWMd0bgakOe3lxrQK/7ypA9o/BBsf
	 jCQEIydHTXpBjppMZgsqTYm/bNmUXTfRT+7B/hnYlLOPfY/CiQuNf2g4tfY4nDTAkLIeZ
	 ATW6QBImIXLxcOeeG7ZROXB9QiZVAxCKix3l7EfkT2fTd/HI5zO8UX75DuEzcj5Xxpfhx
	 vwSY28pXJ1/Ob+GUzcfx9jjlL6eg7Shrl1kp44l6jDK3VzE+EiSM/edIAqZ0Gmhv7LOiD
	 fvHNOkqyhCB9korR15Xtd9mkhW77B08mB1OPw8dxdBVTc3QvHZcAIB95VE8sBD2HYuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329501;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=o/SQ7Gva8qOmp2o6QZ4S+eo7bo7YlRc6KKjRtLL5T9k=;
	b=bhztSifdAF93SSdQxjNojLV40FRR4W0lp60um7eGko/lU65aFoi1bRox4cpe9bHGpGj3
	 QMh3Lboeb7+1Y0xKaPgNIt7JD+vT7edh5DuxuOafcdfCVLN/wkymjYuuy/RvLvqhO2gy2
	 A7BXYbPgzBqvRGsF8X7lEeE7C8Rd+/bHbnSUD51V5ChK1GcAY+ElPhSqM5EpMWfJNpGgM
	 pK/bLlYBVOwADKvQ0sgwCV6Tc9kBaQIfYpA1EKsmK2rgJVnnyHCDfqslgtXiKWkpT/UxF
	 0beHgZLXmx7Bd9UlRGy8CA46Z2zMVImAJxu310YI7ksBU3kdImqX1r+/8wXs4YJ4CJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=JR6NIhGz;
	arc=none smtp.remote-ip=209.85.215.229
Received: from mail-pg1-f229.google.com (mail-pg1-f229.google.com [209.85.215.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27B606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC27B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=JR6NIhGz
Received: by mail-pg1-f229.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so1085409a12.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:51:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329500; x=1794934300;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o/SQ7Gva8qOmp2o6QZ4S+eo7bo7YlRc6KKjRtLL5T9k=;
        b=BJWTBmNKgYIHXuCIrqimvyiwBM3OBe1tCbYQb5Bnt7CV812D7zVJRk0A3QQsW5Qy25
         q8Woz0bm1lnnu6cWaFfnD4NinKGUp+0O9qWRBUx5Oqs20K/l32B20O/b2jhzQ36ngRQp
         jCkr6AHnodcc7WHKqaXtaoeWgKld4IynpIJajrb1nfM8a955dsySg+2aVIDolojloh2f
         zSqOZ3ykWhsgOtUr0ilea19JwRGlM9mUYK1Z3DNZDZqeyQ+xqK2Xoa2Puc/1AkziOf5B
         8E4s/ScOJc0JjSMRQzUh9fhFyWxYSvCzCe6w6CQPNXl2rhE/zLlZ+psciPBYrrwycedI
         fSiA==
X-Forwarded-Encrypted: i=1; AL+hErHhQ6jL1nCtHx35o6kxzmNk8/3QdOFo0HBXpS4wQ6GXWo0Rx226HRiNlg7W2inRiFNwvQYocV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uPHtmYl52Oti2eUsQxS+xWGPYbSXlyesoHIcFBjJdVUME3viJ
	ezfItPWl4IH1o+a/8yFnYEz70Q1bseQclVODdbM75w1mBv4oMgOPg/kco8RXaRL9f9GId+x7IAw
	yX9xdb2ShulhpwR45lzeoDmGtNNCBpoHW1u4Pcbo=
X-Gm-Gg: AYBFou3HfgZemWI3oZL5fmnRpoZH6Fpfc1z7PWkTLQ6YcO0ChBNROk1Xp8NXHFmOTX5
	QvHR2y71nKpcPpJ9WP0ExpNryEoX9LFUTePguAxYuxlLwdbfkneZiuw4gDI8NkVUnxqQOIJ4qAp
	vEHTPeMyF5KfGqtUskb5YOmgIXZ4DbslvXlwjFDXH7pIfTh0GwnAcRqUhrppnTIYTP89fI+IqgP
	JwO3gtUj+QVIKp3STNfVFnlGd0G8eDZJBp/QwmRSuP3mwqO/rbM6T5OPExTX11uu5LcsW+a86V5
	P/Ot6IuCd4F34QbnFrn/ikByTcJ8boJqF7M7oQjFk8TXpttQ5GRVQSjjtXXDUT05iACAnlJaNjK
	9TA==
X-Received: by 2002:a17:90b:524f:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3b166d1e048mr2807447a91.51.1794329500001;
        Tue, 10 Nov 2026 08:51:40 -0800 (PST)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1690d6612sm849123a91.3.2026.11.10.08.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:51:39 -0800 (PST)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1794329496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o/SQ7Gva8qOmp2o6QZ4S+eo7bo7YlRc6KKjRtLL5T9k=;
	b=JR6NIhGz63GCsdBDCS+VcevABkt026EYyHeg4RoU5x/1vjVvFxjLGbdsWJ466KW8Jo1S0g
	eIK6Ya5FZ/+qmLTstvnPdYGqLqn0pWhoqy/hD3f23O/5xYyiRlkprBtHCwsPJtMsD6xjJL
	ASBDpMyMH06gJkkNryeWofeG54kbR+o=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 4507ad81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 16:51:36 +0000 (UTC)
Date: Tue, 10 Nov 2026 17:51:34 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Alexander Ildiyarov <alex@badcode.im>
Cc: alexvancasper@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] wireguard: noise: recheck replay and flood under
 write lock on initiation
Message-ID: <avNLlkTOYf_yYTHE@zx2c4.com>
References: <20261105140815.92841-1-alex@badcode.im>
 <20261105140815.92841-3-alex@badcode.im>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261105140815.92841-3-alex@badcode.im>

On Thu, Nov 05, 2026 at 05:08:15PM +0300, Alexander Ildiyarov wrote:
> wg_noise_handshake_consume_initiation() checks the initiation's
> timestamp against latest_timestamp, and last_initiation_consumption
> against the current time, while holding handshake->lock for reading.
> It then drops the lock and takes it again for writing to store the new
> state, without repeating the checks.
> 
> Incoming handshake packets are spread round-robin over all online CPUs,
> so two copies of the same initiation, received back to back, are
> processed in parallel. Both copies can pass the checks before either of
> them updates latest_timestamp and last_initiation_consumption, so the
> replay and flood protection is bypassed. The responder then creates two
> responses, each with a new ephemeral key, and installs the keypair of
> the last one, while the initiator accepts whichever response arrives
> first. When those differ, the session is unusable until the initiator
> gives up on it and starts a new handshake, and an attacker who can see
> and duplicate initiations can repeat this for every handshake.
> 
> The window is narrow, since the expensive DH computations happen before
> the check, so it is between up_read() and down_write() only. With netem
> duplicating every initiation between two namespaces, no double response
> was observed in 200 handshakes on a 4-CPU VM. With a usleep_range(1000,
> 2000) inserted before down_write() to widen the window, 30 of 50
> duplicated initiations produced two responses, and in 12 of 50 cases
> the session was unusable after the handshake. With this patch applied,
> and the same delay, every duplicate was rejected and all 50 sessions
> worked.
> 
> Fix this by doing the checks again once the write lock is held, keeping
> the read-locked check as a fast path for rejecting replays.

The downside, though, is that now it means there's potential to do flood
attacks that take the exclusive lock, which is what was trying to be
avoided, right?
