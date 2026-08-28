Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479B391E51
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897265; cv=pass; b=ZhuO6fmrrR4qi3L5YTFaZJH66aBKHr8S+24wIApEakKeI49BwY0OWONYwWpcYaoUxaYufTTDv6cNOdSfy2/fhkTzwushQwWCsnXa9bmIe0o/bEon+T0ibeZJo+lnipfKFrrI5XjLPW99rCml9EwrbAJPv/ukDxTxLQVqWNNxNU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897265; c=relaxed/simple;
	bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcbb5JWwLUhrcIe1me6VI2l8m+v91/peDpQDCKV9NH+bO2RM7+Cs+i9rv84bViUKmvUmpygPI/1Gc22HnDnh0Jp4eS1tieWCZUbZXYrwJTtg13jdAlmaxcMal6AMdnwNPX0ysc+c/npR4zm9GCP5RzwQJC5fd/5sEAFdMP0I7V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMQCONaT; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMQCONaT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdce28edeso544585ad.0
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787897264; cv=none;
        d=google.com; s=arc-20260327;
        b=NIFXNtrYRNalG1MbC8iVg0BtDe8cKCLa3XRi8CUfLzy/XeLe/e5kADQIojXnvXegFV
         im5ZglU8TfSDwI79ORnElCgRola3n9bshXZu0wtBY4JSmhwhBpUkPWeP2BEnk1TcH/GR
         va8WMSdLt95eV/TVzo1uFY9VquFs0WAXQ7JrzUierPTdbSHRHboOaDnAkn2eoM7qPOd5
         MHzYQuDrFT8ydP164Pzz87Dvlotgf/xFw6KyIesrudnNo+6aTqbf5bYvzADcg47aZeUT
         GlQlwrFzT8C2ek2zOLk0WFrUxHPUU4uvicbtsqiwMN/eO4xMRBWPWiFWjrWdZdme//eY
         Pmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
        fh=UbHXpB1qely/+wyUFRFrlvN92y4g9kdMZyeoJ+YR2tM=;
        b=CyEGCKmyMnYTmvqyWBts7vrmzuZaRAN4k3UQYIvRX6C7mYFXmLCrBCFv0LIwklASmN
         2aZjXAdjp9XQ+3TYJB0+BdiTH+cXwEmKI2DNBICsPLwM7oZg4AFb8rjLNuw2t9Fzxs97
         dOz9GpjuTjZ2zWiQ9QESh3zLGsdO+ZnkgiaiaGsf5CH+Wj/g5X/xCVBPNnVSlS5gwJC3
         Smg7hfocmCfjXRSuuxJnO58BTJpkuM2UPHd0e7U/z0+9UFY9yAEl5WBeV3j4SDhwvzVL
         qUfu73gVZw2YxFK6hU4HQKQahKBC0c3I3mifQRHknm6YPsvLy4GDlnvit0vhuoCmcjAA
         HRPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787897264; x=1788502064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
        b=sMQCONaTjSW6m+MpET9Nt1FHTXp4Atvz/zy+uQ7O6WMPAAZyNYUws9em7C/fRERWWj
         ozAvGzvwdQO1TWxmVkRzIFBCv4iEIWWIt7/sFpOJNotUK/eO5OSHs75ZmHSlstyN6I03
         81JU9tzAT/6Ok2crepLWo34Q8YLe0rgIFf15S5fAWsdXWZEfT0ix3ODf1F4o/meSc9KH
         qBKCm3BKgUYHKBJ6dQAJOeDUGtWdWmgv53AoqmKKW7OkCB88h01vxeGbURQJaxuaREvc
         Sjiwmgr/Yb8ciaV/YcwDs0JZxiMo3xjQucNhDKpZC8fMbAzN9/vdzSqxMG8HJ6dhXogb
         gbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787897264; x=1788502064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
        b=SQSj5rvZpGbtNRLlaY1IR5wf9B7WvA9Gh3D/NgI783P+kC4tIORF6lmYzBzfVgDldl
         DmRyJJhfJz4tPQT5dF/DOmWC+rFm0frnhsl+WQ1lgAPPtYJr+FObJumvXRJY61G+UJ5A
         VTSfkX/Zl2+j3spkJZXmoRkvwvPHivBQJGp3xNVQ3AYPjtzQAK3PG68U6Ej7MUMz7Io0
         zoOAskKDvk2zZRKdsKH2r1LDUMjyomoYpNTGvBcr5hY3uRCkFaNH1ul7JwzDO/xhwq6x
         71jg69xoSxuwQ3+PvqhjwHz1phPDVM5vzA3mqBcZGjnsdd/pRb3Ib1k2xKKW2IpkIkI+
         sY+w==
X-Forwarded-Encrypted: i=1; AHgh+RohMtWKsm4LlkAeB3KpFOB+Et60GUAhut9Aw1DRYTaBn+yBI1xUCKLq1dWwKRPpNBpPmRseau8=@vger.kernel.org
X-Gm-Message-State: AFuF++kOHF93ePI/0WaUeXOVGZ71sD2DuaMoKaoEUEJcHfCIpcLLQh8U
	G2VKfaYpuunXXINSZiEG+uvxn1nDCrLWbxfAKfsiuEamxUc2HnoJhiG9Bf91/8ijRISBrOmXu7Q
	688dSGDzdni5ZBLqVBTv7mZY7apyKNHQ=
X-Gm-Gg: AR+sD13+PiF53gU1s3KXuh/BrDdN7gVfvgb6LTNvDEhm3SwNyfEVH9hVnrhU/Yg32NY
	VvyIUdKILvHfAA9ehbuKjm4eKaocVHSzYzdEhEh12UYctnzBsDpXrC30ovC4C/QSQffw7Jj5/1N
	c41arYvo/ksVFsTVJFXlE0RCVn1gkB61cKPhfxVgQVS94NSv9904bkRt4viMT1LpISHk4GOn9TS
	3+61dlZXtyd/7kc/KJDIkUFceXQ62cpn3Ned2LPrbcGEZsHx5irlUZmw6UJqtHl8Yc4oKR92MJZ
	hT0qnkA25/fGyPvgbuoQCZPwJUZGRLL5kDyIAfhQsBlosbgb7eYKddMyIRxCJtOCBIYIYjVAAUu
	vKpGbDQvfea7+Y63+CBWn93sJCw76ADYbsAI=
X-Received: by 2002:a17:903:4b27:b0:2d5:cbd3:8eb1 with SMTP id
 d9443c01a7336-2d74df3de99mr39705555ad.3.1787897263642; Thu, 27 Aug 2026
 23:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com> <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
 <willemdebruijn.kernel.361c9e585560e@gmail.com> <apDgeCLGiHTd7fAC@fedora> <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 28 Aug 2026 14:07:31 +0800
X-Gm-Features: AcwNN1XaaWDKqbwKCHnytMQ3rVZm_zSvGLS8Vs_yD6xeEOe67vJOUocYV7nkFHA
Message-ID: <CAH78GvtPSzvaRtph3d9j5CV+wBZNhLEuUN7bvsQVc6DmcfFY1A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, jv@jvosburgh.net, jiri@resnulli.us, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yeah, agreed on steady state.

One thing to flag: packet_snd snapshots dev->hard_header_len at
af_packet.c:3023 (no lock) but pushes the header at :3059 onto whatever
curr_active_slave is then. A concurrent enslave that bumps it in between
-- first non-Ethernet slave 14->24, or a bigger-header failover -- can
leave the in-flight frame short and trip skb_under_panic (oops/panic,
not silent corruption; local DoS for a privileged user).

Happy to drop v1, or hand over the create-time check if you want it closed.
