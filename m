Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBC449B24
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920403; cv=none; b=PqeOcf2+rOlu+pwzGQ04ByWHX9BqCFtyjpBqSHaadIhlllBjjYL9uE+xuMh/sgiaUo0lTVxd+6MndwfwxQtNJDPrgwn4K4V4S6NKzTLTRY0cKZhsY2Yu0CIFo1A9TJN3nggInQRFxkbmGzytyJoJ70aeCnU0emyVarRWQbRmD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920403; c=relaxed/simple;
	bh=bqfJK6AvjcrjKxv8vWiaGOdrwD/fsLSuibq+C9S1YR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDDjKBnHjdsAl6oUx8vD5LSsfSud4BmAyAa97OqxLDLW2+T1g+CS4z+uov+3kfHc42+KgoIaBon/Bn8Rx2iuQ00jGA88wft5BBnQhMMhIRJI3VJAYHyqB1PZrNfiAY+O0BHyyAPrpIZA3d7TohuTEGP03Xj2TCMP1CBwBn6p1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfVCfqsl; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfVCfqsl"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81f64e8dfbcso15869587b3.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787920394; x=1788525194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bqfJK6AvjcrjKxv8vWiaGOdrwD/fsLSuibq+C9S1YR8=;
        b=BfVCfqslo3GL69I4crMY3JvAWuL1m8zKifTWvhLHX9ZJ0lvcRnd5tgmPS8Iawn1TAC
         AyJoMvWzkWa9omMRR+MBal0KqwgbkTGs8QVDnqjjQwwlwgQgw0KFdKTrzDTFz7eKDCwm
         9/mRXG0nRs59A5rIQjS+D4dCD9dXwbo2m5v9UhjHUCaZLZOIWbmr4fqc9Ol5E4/CrktN
         TPb1hnJ0EoD494j4suTvjbCFRcAEPUAflFQ1YHVSVNUVoVt428h9r2eiLhrEREumUo6c
         RCvdaGqCOaULFd5+EgTVuP2WqtyY2Xi9Pba3susZ034rQMDHhvlvldqKoBAUtBlkUGEP
         HZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787920394; x=1788525194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bqfJK6AvjcrjKxv8vWiaGOdrwD/fsLSuibq+C9S1YR8=;
        b=h9hRa2t37oNF09PLi1YR0gKEDS5Sj7eBFPVTm8BKKBXM7Zk3OnvqhXTIhqLRg2udi5
         p8jdIk9qUdmtmUrz6pgJsxBVfstg321jhIodMVGYXuwuYlaK/Wu57N+vohh7Nbuv4WnE
         /3hs+xA7tQNqGG5tk3t87LJAEODQgNoC25FX05T038jfV2/Fwj3daPtzKM6wwMmjh7GY
         SLBnuI8KUZWWC0CVVajTtacoFqg+tBQfIebyT+X42Pn/sSHvNxafkYFCIHSW+5bWjD1m
         2x7hwIVbUCMhlBfZlMWNjfq4U4NgMOTZwGgR6cB5dUuDKNzkYzOfpZP0AzAstGAATQ3D
         T40w==
X-Forwarded-Encrypted: i=1; AKwUvBxQhqH/0/xfrz4NTfKaB1b/3/WHSKcyEyhhmbB/QqLHEGzWOiMgpjSuf8SfQTlQwrkAlvaFsio=@vger.kernel.org
X-Gm-Message-State: AFuF++n7UpWGB7OtefaVMj6s9sMlQQARlIm7dnq+Q2IgzO93d74Skb4y
	8PIluIAmhsfrbA706OPNvQ8zrdFyzeJ9wq3ix8BATUwfmiXO+UziQrIB
X-Gm-Gg: AYBFou2iwhH0RRmPD8zWTu1DS2Hyuuhc4UcS6x1nJFCbhBakE0bkZD1mn+OTv1+VPsM
	d5i6JBNAiA9YSf/dYQSd7XnpaQ4TwbD+k/cvyTAv0VcNfb86LSRxXhdcWx9XLF2uUPgxZ2Z+so2
	Td4zZr+4PJ+3DFjqgRt7F9hv+zxr0bWdLqXQw5XhCpb9qvG67TLmZo+TM7I6Qr2msvUg/DbO9Fl
	kYLkvZOIDFVvejfSWESGtPjUce1+BkB+OtBKSB1pkXvO2Ld3Dkb6GREmIu1tMQf/Da4DX8MTtEd
	OapQfruMQzMVj/YJxhWjqYjb2A3sFHu2RlLgHbItr3KmVw7yrWq1Si41rhH4GVJjTqMkXPwChVq
	ggGqKP3aaafERsGY/Pv7j5MxwT/khPTiAe3tDzdiZlAvkBSgmcvtmF5G2TiIA12ljFsqi9BN+rQ
	adKTFgAd+zAOeBtrELANeNatdUJKhIHWUzIPThzi1MzloH8/czwvdioJ/8EOIFQmX0T3s=
X-Received: by 2002:a05:690c:6ac6:b0:854:4fdc:cab9 with SMTP id 00721157ae682-85d65ee9995mr32089877b3.6.1787920394110;
        Fri, 28 Aug 2026 05:33:14 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5f4f3b6csm5435987b3.20.2026.08.28.05.33.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 28 Aug 2026 05:33:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: gregkh@linuxfoundation.org
Cc: AutonomousCodeSecurity@microsoft.com,
	Dai.Ngo@oracle.com,
	bfields@fieldses.org,
	blbllhy@gmail.com,
	cel@kernel.org,
	jlayton@kernel.org,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	tom@talpey.com,
	xmei5@asu.edu
Subject: Re: [PATCH] nfsd: hold cl_lock in client_has_state()
Date: Fri, 28 Aug 2026 08:33:12 -0400
Message-ID: <20260828123312.26927-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082828-palpable-dingo-241b@gregkh>
References: <2026082828-palpable-dingo-241b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please use your microsoft.com email address, and not a random gmail.com
> address.

Sorry for making you raise this again. I will hold off on new patch
submissions until my approved Microsoft email address is available,
which should be soon.

Thanks,
Cen
