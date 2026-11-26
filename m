Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663971;
	b=3q5FbYlOfGZpQUR3DaHi3MGhtxzMvMkAi5Sk2qPCqk8ijfhNJU8HzqmZKxtnsn2E/0aL
	 x5ygpHy9pf4MgQ8wJB01cCmq1lNwaE0c/tPxTnG+1yQe28HthIAJ9Zb3T3yaoIEDrp6Eg
	 1Gf6y8oLYRc53dVOaG+G9j2tvUpu/7n8l3t9IpeQRiJO76g/tK9Uxxu8bVwFTrDm8Anka
	 YxJ92CU34Q/FQN4lbCP6R4/x2GnOoYILsE4rlo5LzXn99PEWqtLA5MS2u/usC9oA0q2jf
	 eZXjpOD4tiZ6OupV/vnVRU8MtJTmrkcyAllG6/g5FXJu7EDIh8zgqQH8lbg+r1247Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KqMXbibufbrLO7FuyYV+tOnQOeMcHqxXW03JIGh+8Oo=;
	b=beqVNbBEVzPIOvOnacrlkYv5St/zw1QRUxhZly3eFp3vItIDnkvkENSoyjFBe1ca59e8
	 jDJlfhgibVL42jbDAq6i6EMhUZUq5jfAE1T9efSkiDAcDUjgMWu7POC9qZv6UyAqnFIx+
	 ytuLMOIBnx5856ZTbmS1jRijAKsqXsIdUsap2VSvvFt2mLJPH78IuHVCmNPwpoFipOqJn
	 maJzLmvBmFB81dL4BZyoCe8s1IMMHu9QrZ+wQ/ZQcJ8wxuqf0M05Nk/r320AtrRX+wEMR
	 GVtBIgDI5rcNEqF69iEX36elKrnpotvKI/LbKnEkPkg7YP0FTy+EREA86t7q2OMYbOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=nGgCfqoy;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D63606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D63606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=nGgCfqoy
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-949589c1495so575623385a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795663969; x=1796268769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KqMXbibufbrLO7FuyYV+tOnQOeMcHqxXW03JIGh+8Oo=;
        b=nGgCfqoywj9N/UUp7RYNDrk/Qi2joonPlUffAD7sOSXdh6zAawTaKRgf1d7HiE6UZY
         CwjJoT/XL7zLyDwjc4hFtjAmEy0dpsZQA+FZeZqfpxD/b2UbyZi3eruENCC2BfaEFn6J
         WGmgmKPAu7ZJzH6q0KlAkzFmFA6h9RrkNLpz2EWNEmw6OszUWO2rZwoLdnTPSHb1qrSf
         T4D5DeYYk/F4IXdF0VpddCKa12jrea5Hikgp61s5zP+E8Gy1KissJcu2uJPYrSLw03m1
         X9hPHDBzGAfq7bOQ6+7ApKMl815qJGek1c9fEtTEF1wA6txT6e386vvmBUwGMK9ANYMF
         X4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663969; x=1796268769;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KqMXbibufbrLO7FuyYV+tOnQOeMcHqxXW03JIGh+8Oo=;
        b=Zp7xwFbUiqOJ/WgYTiZ5tr/4lNUHnsVqvIwc3pI4iqhAhQwLRvDkzC3rp9ioz1qDvJ
         C9MYELMkyBW34Yt0Xe+7ItAb9fX4uflWcrOv8xH1rHnvcDhhvu+yeL6J13+6JwcApy0V
         tFP4oxE7eU2sVPwsVWNvkRQR3dU+JBYC9UzagpZpoZluvJH4t/wyhtKyRoJlUylve605
         LOo5V+Zj+OPQpa46DFhozEaom0cMH0Ms7Zq0oWntY3L/98KbxS0qMNnLNfyk7LWcAVRN
         mwvgJte+GZaAEtiZ8mWl8IcXcM15HO24q9c7f46UybykKuedmd8LcMWn0CBtxTeVqmAN
         N4UQ==
X-Forwarded-Encrypted: i=1; AL+hErHegkx2uBH9yeCrj/yJ+e8Sd8S6vcR48rhIsDkh/Hnejj93Uhp+tGfToR5ZPFCyh41GWGbHnFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/FWcaXldJfG5Xf77Au9hODiD4MRzvdhH8U/bRJjttXeWQ9N5V
	i0BjbAx0718CTX2FHmkreurqiXdsXtBDfA7TEWGa4IoFcMFSoKWOS9tVAkC4+gaMpw==
X-Gm-Gg: AZFdTZfhhWam2EDzlm04fo4ZyFj0OdKDAdlDiH8TznRSlTYVRE7690b9fEVky986cIF
	xqWmyOykuTyo3Se//PzX9uE7gqehxzSdQaYNIkgKfEdzy2oH8K/B1R2GAKg3Z1MB1HxAcu0ycEP
	cT2zJ/BuPw8Y0NrgeFmxgTFaLp6XnP7U6zaoo4fcr1QoCRpFulZGjJ8fzjy3BLXiIYrROG2SFjQ
	GScDSzxdMCo1qBSObKwQqBOOF+7cmyu0nvvNl+ovultcMOezrCv/7pf7bFtmPzJ9nkhs3gWDM7+
	tF0DZ4DQ6i6c3VZLXOWAL+hQAPryLh74dQMHUgH+wXDmYdtKe2jDradnQZYXaTpsmgijhH0+b1e
	bnvdcncK5EMRv6ahKQ5GN4vskkC2XCHo8z7buBREwxyU6tf5bQXrOZK0DU7cGCFQTlKiGVt6SsQ
	9Rc1MqId7cNpBAtKYB9BIi/DDlOxNunBqhrHfuik1EPFHV422J83QEmHHZoUKyJGxnyioGSRJkV
	ezU1FmKLKT+uf+RF5UAr/Mn9SzE6EGrA+tisxzxvMQeAfeqwcpgywodg95EIVBxFafnWqBjTQw7
	k6nmmwYAS0Z20/MEIyQSgYHXfRGjPA==
X-Received: by 2002:a05:620a:46a5:b0:93f:6c76:215 with SMTP id af79cd13be357-949bab157e4mr3534856885a.50.1795663969349;
        Wed, 25 Nov 2026 19:32:49 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::9a34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949ca6a0693sm1245909585a.20.2026.11.25.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:32:48 -0800 (PST)
Date: Wed, 25 Nov 2026 22:32:46 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: kayano050408@gmail.com
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 3/4] usb: gadget: gadgetfs: prevent ep0 event counter
 underflow
Message-ID: <3fe932e7-fa30-4d3f-917a-2ac8c3fd9605@rowland.harvard.edu>
References: <20261110-gadgetfs-ep0-v8-v8-0-8f90434574fe@gmail.com>
 <20261110-gadgetfs-ep0-v8-v8-3-8f90434574fe@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-gadgetfs-ep0-v8-v8-3-8f90434574fe@gmail.com>

On Tue, Nov 10, 2026 at 12:13:24PM +0800, Jing Lin via B4 Relay wrote:
> From: Jing Lin <kayano050408@gmail.com>
> 
> ep0_read() snapshots dev->ev_next, drops dev->lock while copy_to_user()
> runs directly from dev->event[], and subtracts the snapshot afterwards.
> A concurrent disconnect, connect, setup, or another reader can reset,
> deduplicate, or consume the queue in that window.  This races on
> dev->event[], can drop newly arrived GADGETFS_SETUP events, and wraps
> dev->ev_next if the queue shrinks below the snapshot.
> 
> Dequeue the events into the local buffer and update dev->ev_next before
> dropping dev->lock for copy_to_user().
> 
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jing Lin <kayano050408@gmail.com>
> ---

This and the 4/4 patch look good.  They may need a little adjustment 
after you update the first two patches, though.

Alan Stern
