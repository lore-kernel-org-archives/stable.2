Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483943;
	b=c/4S0AHKhWByZFgNXd6ud1ResUyaQPwc5Y1T4XDYL/TH1yABfs1oG2k01g/IfIsmPXxR
	 crAMBW1j7UKf87PoQVK7GKjnHf774AnVIbA4Bo47q2dmqn71oPqrbc2BVBYVmQpKf8tIK
	 se0tGsVSCzJMqLmfE20BWA+ai3YebdNzxDo0OoIDiX02T8P8jEFjKlUgCWdd9v30eoSjv
	 CWOoLxVvb1pS9Lo1d7czzomTXVk77xUe9RTtOpMtSJudlEwGT1AtsQt/8AKm1rGxbC0nO
	 gkUAfrgCDMG0dccTi+m47TrO3ebT5G4xBXoCjcLQSYLDEPJRloeul8Xl+8NnqtZeqrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nAKiNemk2GJJwDYP8p1zRplDTIqlR1poJkDMNc9BGdA=;
	b=UdWEJPN9cSdLgHd35F/XzsWLuE6Bhp9/IPGjEODg3YJqeTIbkvp5/fy24XwkKog3HpOr
	 Zmn2wpBfh7Jpr80KfIfoxmkum5Ao/rwvOZhkvFWFZqUHdyDCAnh9aDY+Cb6B/tJsK7ZiL
	 Qk9aFv2EQT1t5sTTkOK8GAXQ+qzhLiXDMZhCyEb0Jqle2KITFM2u7cijHtMy8WRbRdo0A
	 yEEDuSP7iizhGCR6c02JearqO0WM1s3hlKlw7J8C3ZkBI0bHlXhgX2kM1PviZ+K1ZCUoc
	 czDD2t51JvAvTMErcDwcpLsTLmAPJyxP+dvjEVLrF5Skjkr4AdMF7LgZHJHdIaoRz7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgZSWi0C;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0352606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 01:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0352606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgZSWi0C
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3b4944a0eso2818920c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483942; x=1796088742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nAKiNemk2GJJwDYP8p1zRplDTIqlR1poJkDMNc9BGdA=;
        b=fgZSWi0CfA8PjW8babAeGvHSPwaWYbL89BEAHJy+ktqIoYDUEZME1smhCOfnnxW0+v
         AFjfxviZRLBb005A2J+N/u36TKD+8tMxY/1SOdJbY7xYvu/hKN6jekjXk0e1gaIPmd74
         QPSr+c9G1gHQukDwmEGlBUeunAbqz5t0Vbq4EqemoslU1kmBx3b8CA+HoBhDsv0ArvYq
         U+QjlfzW1u1efaiUDglKRnzWqaBCiPSsx7ev1Q6t8ZLwrCeywfWkt5bYPmdbipveu3Tw
         bK8aaKxc3z/js/1HAmRkiAQn8uwcnzE+jUkhP05Jyge0CHDjEMfxgwhiIi2bShYoInug
         rYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483942; x=1796088742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nAKiNemk2GJJwDYP8p1zRplDTIqlR1poJkDMNc9BGdA=;
        b=OxlCW58o7+m+RmqNxfzBAdgOoTuiKHjYYRfJWLCnC111/63Bi50KCaZEsU//yB+vHp
         zIUqtHImFdDeztcvkVPYg+p1tXV3PJysRtOe3vcEcTARwP7zJ/BQtiL7+SvM+QSsqCSM
         RPszy75CkRDX13xc+hnx2I3f80VMelUdW2O37tjXKCi5wBZUK8yrJ8OfU0m/PXDy/461
         93gpFJJaihoN2QUlC81Jr/etlvu17CSLZNgdg3x/J+qxW8ADj09jwJYf5/T26wB2zyxz
         8/S+NeWrYbWPYtkgE4pOOrya7/hdXY6HbUizXNekjGuST5xzpUc4PbfiakLEWlQfKWE9
         q/Bw==
X-Forwarded-Encrypted: i=1; AL+hErE7FV76RIQ3rvY2Lyna/sGJuEx1kgpTrf2xKBleTOenw9YoeexB4JLueQE4glwtvqBGm9kjJn0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gg2EWdXzxUsiYmThVxHPbBPKmA9b8ZL28qU8IS6x9VNH1JJ9O
	vHPhZ5sx3VuEYYvMs5JvMtovYNA/BKUiXj9gMoDdCSTqwsQibXB8zDiECRKqG3uc
X-Gm-Gg: AZFdTZcwX0Gvvd0G2RdvoOCMgHSr8xd1pRSN3VUKm5a6Nh6JVLPTrh7SrwgKJBk+c7U
	zHsGIm9nBJxszUpDfxw6rVwlCVjjZ8Bjmxt1R6egYL1aguSY6x5tXOJ9iKBfs/aJTpTUZ2oKb2t
	sgEAYxxmHEITy1a4qU9Z9t6kwsD8T8F3d6Z7T+j/2Tqf2ea61S7NNotXAEvH90GSb4PNY+zSzut
	w2DJRd9FKa3cZAKIo67zDIL9wfpVzflSMMtClz3BnqwlBg11LvAqgItzkqs3RFRElPWAxym8AkV
	RlPztq83D3OAG0a145uwbC2EDm1qJYjxtM+MZG/TG7Wxq3vaq6jMNcmARedxlGvudj4QCeH8pSO
	V4HzgAAhJQgDlH/2gX5lqiadZwc1/I1RLobjLZntNy2JNknDkBBtGcYb29KrtpXJyYWgYyVnnmn
	ZFRfEIQHHM/cCX/INgIOk1wKPZmIKLGakqggPny4m93jAGI411WINgD3bACeNJlHynM67NY/j8k
	zpHG2PUHg+CLkyUNk7hhZv+bgrFq90m4+Yt5h9QJqVaKulEc8Xr3SGJE1Zx4UxLaCdpyHQMa6ei
	ys0cpgsJ4BH1xe+AeXXnPZN4PUukOZpMqgGFhdiVhwxRAVDKtYuU31Vvg64rkEorx9FWlB0=
X-Received: by 2002:a05:7022:f90b:b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5568ebfaamr12146790c88.30.1795483941534;
        Mon, 23 Nov 2026 17:32:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm34017451c88.6.2026.11.23.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:32:20 -0800 (PST)
Date: Mon, 23 Nov 2026 17:32:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: xen-kbdfront - bound the backend-supplied
 keycode
Message-ID: <awTpHuucnYYCHdx7@google.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
 <20261106020217.48481-1-guozh23@xiaopeng.com>
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
In-Reply-To: <20261106020217.48481-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 10:02:17AM +0800, Guo Zihao wrote:
> Keycodes arrive from the shared ring the backend writes:
> 
> 	if (test_bit(key->keycode, info->ptr->keybit)) {
> 		dev = info->ptr;
> 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
> 		...
> 	} else {
> 		pr_warn("unhandled keycode 0x%x\n", key->keycode);
> 		return;
> 	}
> 
> The keycode is a plain u32 from the ring page, while the keybit
> bitmaps it is tested against are sized for the KEY_CNT keycode bits
> declared to the input core. A backend that sends a keycode at or
> above KEY_CNT makes test_bit() read past the bitmap to decide which
> device gets the event, and no keycode at or above KEY_MAX is a valid
> EV_KEY code in the first place.
> 
> Since the event sits in memory the backend keeps writing access to,
> the keycode must also be fetched exactly once: re-reading key->keycode
> after the bounds check would let a concurrent backend write feed an
> unchecked value to test_bit() and input_event(). Snapshot the keycode
> into a local variable with READ_ONCE() before validating it, and use
> the snapshot (as well as the already snapshotted pressed value)
> throughout.
> 
> Ignore keycodes the bitmaps cannot hold.
> 
> Fixes: 4ee36dc08e5c ("xen pvfb: Para-virtual framebuffer, keyboard and pointer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
