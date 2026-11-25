Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587874;
	b=eR2lj+kvV5FvqhNJRcvVzjDBcYAuJ8lIBL7+uILjQcOaTSUiEg7FBbd/AWJ7YwT9xW0Y
	 fdXdyStDaV5/k3V6LMfbOUPabpTPdRE89GZWKWrg7KT0zJovfc0/ATgphchPxCZbmrWCT
	 1ca5NDdByEfpZZTiFvBtjHNHQA8m99QUiRYbfbFppl4TF2CBTf7PVZe0oftVbMUjbmL4d
	 wEhvBSqfilhlVsRIS6DKW2rDQQDefKOdO4Tt3ko8esuG/M4JEhsZMivxQfJhufj2pIOaz
	 yct8gep4hsaiwEPi3u5/Nv7b3kCwjpiUk0FlvTnryrVyfbuO1FUuGAfFUthLTscLvuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZQsWRLmOjI6MWITE5i2BHhTTEhDrYVeR825HJ9sXg2s=;
	b=KMLvDAA4CnYMNK3ohkCdhjYcvIyUf8Dpwk0jXQcnLeADNiF9SxCGCY7FAbLBzPrVsQlB
	 9JtahtRWfIlJ6ZndLtyW56GJm02DorNrUTYMYeyUKNDD8/Ib+xKAnEOGVcw4a+7uVSovn
	 42GDOYgdvmWS+3/OnwEsFVvV1xsqM/JedAWn5/wEGC43zdOG4fNhGP4I9IHUMCcVPwvKn
	 rCMEmekzRS9isG3r4D6rPbsJG6+2YEFDAUYhgqZ+nugvE9EElVSp6s8LbIs7gG8LLvxTO
	 7Am1Jj1Rvu28wBkLS/VKhlCW7qI47K8I/6d0S38nQBZ8T64ZUGJ6e6rSvmSCrfUgNqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=ArV2ryvm;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD5606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBCD5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=ArV2ryvm
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb2dfcca94so2258604a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1795587868; x=1796192668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQsWRLmOjI6MWITE5i2BHhTTEhDrYVeR825HJ9sXg2s=;
        b=ArV2ryvm/qDFsW/4BJC0tMGbCOx2gT6SWvkk2itkNge9rQIPDAYUHGyHGeLQquK14z
         LtDohwxclssuBm09UuyCAuokUt0RIRpXxuQ/zzqQgRqvdMzHfLuW7Q4N8iyTcfVwiaoi
         +WpcIhYtD7BqMB49/MS4wypCCURlt2ttyZUO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587868; x=1796192668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQsWRLmOjI6MWITE5i2BHhTTEhDrYVeR825HJ9sXg2s=;
        b=dDDdvKxWR4fg3BNaeIO7cfbwXYXR0P19H1P4UBPzK0nmMhJa5Tmt2nJD5GUjQBA+oI
         HIW+NZZ010/13j+kAjOphHpa9Mm9COXmWaiRmeSErWhtg/gcvmbyaZXeLYOEzdAMV0sg
         Fw8So3jjbdqZeVToI7Dzz3J+9hL7MF6VRj6OYgcH2zEFXTdqVTV2nj6FYHXZnqe7yaUn
         /w8T9kYjaD3/NbCMieaF/FKi7+Mf6OvEq4ybuCiW/S4Qcg/TymutXMMEeFGualtygvAo
         WbkuyGMFqi0S7vfUNUomq/14n3aeQRtJc3ZXYn1+Z+QX9pYaS74ktHR3ik57/42CB0Cf
         0dGw==
X-Forwarded-Encrypted: i=1; AL+hErHcaY720+AaRdRO1pN2AHqSMDxa2CBaD9GaAtqQCIXvOWofEW3UAtbc4hevPDmVnGoBimeCCSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+o/mIKZsQbqQ1pSfmgmAdXIKVUo4e7aR/ulLIsZa+1skA8BFxl
	QTsE8Mmj8GuAKz3B+FABTnITxIK18lsIDKCt2yRuEbL0Zg/LhYTNzDElBdxQ0uhotvWgcpQDRBI
	b8cMoR2TO7g==
X-Gm-Gg: AZFdTZe9lnznXUI6lLWk79QL+eGtsiWOY52iKdve2pEFIBmKI+vhl+MMZ4J4h/orNLH
	ohxmR4vzJzw0UP6NJyhV+Py1a9Pm2WOIZpew+pnbcTp1LJf1LNgoMS9s/TaqnvQAVHvi+FfZZjo
	1SGuaNxUgFM2bhxL06e0cEuNp7nhf1MppIxyDmTQnjj/YwlaBLw5eFgPPJHgh4FSb0aazzcG0Z8
	xJvgb07MKpd/Xeqba6AQtjmkS48u5C0FyHhgvJUp5Fncf5HqBgwP+kqCNGg1OWzAUYwZGShHBHp
	E9DzMoKzrJZZRADjAGPFSDVPtR9pcE85JB/djguiktDFlhU55+n7cbyvPrOJYenrxrCjETxoBhl
	qcoqH29ZUbTEhluX1mUWMymn4Z4UhKZOlrxmbP7O9Z7vYFYF1wqdUgwocQfAzK/R/7HOEk9t+ok
	ETaZhj3uM0wm2hY9oIMWqDh36KQOQF371SE9JHStEDh9Doyk+1wjTbl9qa7yjwXQ0xKx2I+srhX
	MwYaWHdHIkpvLgKeiM92TEw+/SjS8O0ieWWf3GgYuXwMaNZDSYwq4lRWabglhtvMnhcrfHC06VT
	e8ZRuIu65taBLS2zc3lbr1Zk0Zp05ZRevXLqTbCiIKrKkTGC1FkvMsKst59h8j+zC6GBRlrorZB
	l7NnPC1GXKjaZ5139nLUpM4th9qZmFTYKT7VdU66HD01+Cy/OIj2TKQ6lsCJ8MpW3ahWmmol5UT
	wo7RWBNiMQtA==
X-Received: by 2002:a17:90b:3d4d:b0:3b3:b71e:b2f3 with SMTP id 98e67ed59e1d1-3b41c95967emr16704304a91.45.1795587868123;
        Tue, 24 Nov 2026 22:24:28 -0800 (PST)
Received: from iiitd-S2600STB.iiitd.edu.in ([103.25.231.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm29191820a91.15.2026.11.24.22.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:24:27 -0800 (PST)
From: Piyus Kedia <piyus@iiitd.ac.in>
To: johannes@sipsolutions.net
Cc: kapil@presceralabs.ai,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	piyus@iiitd.ac.in,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: mac80211: do not copy the mesh RSN IE twice into the beacon
Date: Wed, 25 Nov 2026 11:54:22 +0530
Message-Id: <20261125062422.948748-1-piyus@iiitd.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ac39fb1720fc03069317f8a74aa0f34d86db2e30.camel@sipsolutions.net>
References: <ac39fb1720fc03069317f8a74aa0f34d86db2e30.camel@sipsolutions.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johannes,

Thanks for the review, and apologies for the delayed response. We have posted an updated version of the patch addressing the netdev-bot+sashiko feedback here: https://lore.kernel.org/all/20261125043805.883952-1-piyus@iiitd.ac.in/

We also plan to send a follow-up revision shortly to clarify and rewrite the commit message more concisely. Please let us know if you have any other feedback on the changes.

Best regards,
Piyus
