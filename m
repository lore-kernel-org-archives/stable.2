Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612133E35C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336792; cv=none; b=SPHKyiE6n77HTyjCuNnoZn+oEpamuSlGMpIrytUmG64GHfCFUtH4VBHBviIefdeDUf2HTlycH3Cs/fkd4n/MOOkVxoqZFCtkqX0p/uCTIoOG2N5HnPHyfaNzr3kgFg5KUpGiMXTBKZIS50DW6kvSdahV0yd+vZWFL7uXtsRTUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336792; c=relaxed/simple;
	bh=yT4qk//tC5xJd5Q78Wf4BjrbWUdWEvx1U2HF6URaQYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiSFR+gNnRnMh4hxOl94wS+FwNN7G14f+aT//ruYYkAR161yoCuG2VYLlZ5FDVzLNdRS1IgkAYkCZCPWi3CEY7Oq2/TpU7AVXb7tqisNlrdiywMm6Gi3dSsgrmgO+CB3CCjlqGnb8cvIky9S/FTmybpYYbaO9UV1Qw4ROsdk4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC4jiT5R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC4jiT5R"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e2de97b4d2so11492695ad.2
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336790; x=1791941590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kt3VjxAsGdSe7dCl89WOHYsP0HUrLZc3A78+p+uWquA=;
        b=fC4jiT5R6+4CtccnjJz79W3VL4sYdkWB87WBVTVWsmwTdsPDvwyzlQ6Tx3G7G3ZMjT
         MXw+0hsEpLVcpuerGXlg/9zzmLv+BPJ84Pf/uLNfIRvcCsYj+lmJfg4a2tveAqaM40SE
         DNxrCQ9V7WLOHTj0RA0HNtAPZoyL/ZOWZxgZ1cHgAYX0XRn6Lylclc0oK7tjNILG7MuC
         cT4LbVN6ZbAVTRRCqThsmdzc1cZLeB4mvPPGTZF1XL3fGLWYGmfDTzeBMniZE+dpz2Xc
         zD/8eNSG+q+DRK5QPt2l/kLyG8PZtAVSsmD72VgVeed+JimrcOqxQ8mkidjRtccEskIc
         INUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336790; x=1791941590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kt3VjxAsGdSe7dCl89WOHYsP0HUrLZc3A78+p+uWquA=;
        b=HEFlU+N74W3+/L58Lsgoo5wVvB4XEXHvUcaeFRMqfurz5cZx62k08JtlNo64fo22z9
         acz+oEHnSCia8Uk/mKUb33aBEokEGmpadCrJiED1z7zWYUnkv4htmaVy4yPVOJV23QR0
         hZ1T25pJSzkHfGBaQtgaSeo88DdgIOyoDbX0MwjEJKAkY5ku4d0Ez/2LwLbgstuqLekW
         v1s3//uhVVovrP9JcONQPcpRwD9zCqIxWGHrk7GTQnxjY/7Obzf5/xmGhPMWnxZ1lXT6
         KJfPF9zkzSJnw0Y5KztOTdAZzp0MkA7zp7i+RYbgJq7pA+Pwr7bTPhpCY6ca8ifdlZGj
         RQCA==
X-Forwarded-Encrypted: i=1; AKwUvBxhvNrYNQBZ2wR59BykO/+728EO7i5pjUV67r+cOBVTOhs9NY2uiIoeaSguwwMUKXiY4hX0W/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIMn8lFCOHqc10JxL+NkxY0LFJKQ4bWFSVvhOTsAPXhKUYIbIR
	Ogic/b7KW36cPOPprhhdNrSGXHkfff3T2loMyLvE3OjRVvTgRL42sePR
X-Gm-Gg: AYBFou3gFFv4jlZcSIsRqIF738b5S9UyT5NLzgEwS/tLgeO+s2xuCC9zEWnjdNIqR38
	0nur+wxlxiP6Cu1WbyMEbHbBHmjukTCjnRxs8Q98dUtOnT/ReK1NfrBsgAiMCzvNlC1AsivSvnu
	yIMkrBdHMtYSAud8F/jA/YHgF6A5ZNIHJqeJraVTbUKMIZB8lIURgBzrdi/WiBnh0OD9kdJbRDQ
	rCa3dGZyMdTIw3+2vYvlgYHG8O71/dA0QcJJRrKqxoM0y22uN7bZkQIM0yaEjEA0jaAVw/+o/+5
	7MzfgAlCIsC5GH3lSBXg2GIYGJy4/ohqfCo/Rol/YST55XWpPDXvA+rJMnR0UkjTvUWThGI/++Q
	QVUCoR7kDUfwdZC1o/6LAV0HFXoxXq2GmKRYHkBhH8ut/AC9uIRhjji3VNrI9cGEXd6Qu64Jf6c
	4S9YMmVNmU0mn11S3IJC4+LcrYfyoF7ZSxQQ4ScCO/NYMx6Mw1kF6098KF/ooqLgbzxzZje/N55
	lPStasOV4DF
X-Received: by 2002:a17:903:1b24:b0:2e2:ca04:fdae with SMTP id d9443c01a7336-2e6003c35admr8419835ad.30.1791336790576;
        Tue, 06 Oct 2026 18:33:10 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604852079sm2958395ad.60.2026.10.06.18.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:33:10 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v2 net] netfilter: conntrack: reject nested ctnetlink master chains
Date: Wed,  7 Oct 2026 10:33:01 +0900
Message-ID: <20261007013301.2524415-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179127347858.434549.11821822167265441355@kernel.org>
References: <20261001180224.1018290-1-4ncienth@gmail.com> <20261002165601.1754467-1-4ncienth@gmail.com> <179127347858.434549.11821822167265441355@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.  All three points are valid.

The nft ct expectation object can attach its internal helper to an
unconfirmed expected child, then arm the next expectation with that child
as master.  I confirmed a bounded four-entry chain through this path, and
current net retains the same unchecked transition.  An nft helper followed
by IPCTNL_MSG_EXP_NEW can repeat in the same way.  The H.323 Q.931
call-forwarding path also propagates its helper without a depth bound.

The CT_NEW compatibility concern is valid as well.  CTA_TUPLE_MASTER was
introduced for conntrackd replication, so rejecting nested helper-created
state changes that interface.

V2 is therefore incomplete and should not be applied.  I have reworked the
replacement to make master destruction stack-safe while preserving nested
expectation semantics.

pw-bot: cr
