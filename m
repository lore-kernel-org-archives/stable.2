Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792804484;
	b=IRwU6Vx+OPumBNwWmv+IucvMzTjLJ+M4e3FU7UFDKb2C0IfATPHHXD6wL3VQZ5wEPE5h
	 nwgTYKjKLDiPPh5YVvO6naRdOpgCW6umvgOfW9b+2Dqu5WdddEKe12wXED7DSgQNkFZp+
	 keNOBFYIVJl/UjxFHFeAhTrw+pm/bbJmSmVmFsYPid+RzS7HJX85LBtskcFtb09Sd7LH6
	 XHhia3rEgVnI+7NlcKToSnKYoKIkp7YlE8AEZ4KnR0itI+H2BGJgx1FAFTQxESoaMD5nE
	 89d26irKyrLR2O/ZKEQPgmX4Z5E0BkrL3dRtOyAzQa3nwP84wDW6xXIpISzThxjG2UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792804484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=lW3J89fIlZE1k/PGBlzPqSNLS0AejPIUQeZxW/w7Yuk=;
	b=BH3rxZ8WpRmhLoCiEY3TSvhQdRBorOVUdARZEDhKhmSsGye6mbi/AUDUyemeYEE5ihrb
	 6C+bAOOCvIjVs7xyOj97YdOGKiIQNsbucpFgJPl3zLSn/0uEaepjrV+JQfgbjkt3v2q1X
	 eNn4Q8eMViax5MhQaZR8M4PvkVFdWPVXAZEDOT3dihjfPQKBS4VOJXXhkOEXXe8UTxtFM
	 iKAjsb0UcLgRpbyhDMUD+0wI74/U/I+j39EbIxYUOMx9TxeI2cJoX4tVJU4bnExhBCpyG
	 i2kI1wN5D9HmzAMA9hAdEeDQHFwld4wGg5SwASUIF7r70TGditAOT018YUC91Yi06Zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="PeR/C5vd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A7606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 01:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15A7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PeR/C5vd
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0dba37a7fso12301837b3.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792804482; cv=none;
        d=google.com; s=arc-20260327;
        b=GfNBOh2wjlLjFqjtIMusHYubEioDXPscTiG0KS0kS0a9EYFOit6dOyP4hNdopl+ev/
         l7S57JKZUT4pyKtNmtnOBFbI8uK4xPsTZwR7m8mB5rb1ko0zA7W9NJ/J+D/E8JBNsFw1
         JKa9XyVb4RZKxqec5UNQ1Q5Jd18nhSYLzLO1pJIWPd4y5OiTGNYmZ+XPA9PGRnxQCVfE
         TmlkL2JyqPjQIm89TaqDVdwKYxFISvKG3Xkgv8CTIedYVJ17gp+mDL/7qWnh6nFNhmcW
         E2AdwlU4Kn9RWGJisZiU2FqZjQyE9XeIvyECL+yoTr97yMuP/Z1bhck1yIYVf1ee5j9R
         C3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lW3J89fIlZE1k/PGBlzPqSNLS0AejPIUQeZxW/w7Yuk=;
        fh=ia1r+bBHoWIJ2pYECOZIpDZq0Bu54voCFXSXAj3Ece4=;
        b=SXIbzJ+uAPrQonyqI8W5zK9AtX4imubrJbzQAq0j2B6j0m7ySsca/BZ4U34GVyFX0i
         MeLjmty7iMOBOmUpURyLrZbC34Z38uFu+f26kwDGhq4zCDnG0kxwdD87MK4PsW/FHvTv
         YwOYxQzu35vh2kN/TUTPNam8D6Wqdil6cCVpSnKZOVgl83Q2krXVp1nCNI+IMe3zf+6E
         yWdFd+dn3CrKBEI6Io7Lau49YFOtmdYWc5bnm+a7g1uEYOVrk5XpofCErNYMqOroJB4U
         bE5EcN1TBNq99GyiyCFxZ8Nh0LA5xitbX6jEdnH7Ia7Ziit0A7mN3ByXKNM+QJZAjrKa
         w6ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792804482; x=1793409282; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lW3J89fIlZE1k/PGBlzPqSNLS0AejPIUQeZxW/w7Yuk=;
        b=PeR/C5vdkN+oty461dcEsTpC98mgTKpCOBl+XDpClyxyoK47hlznmj9MHm1hcaDf2F
         huhsaPOWr6Q1fsnZqXiJSgC1NgXD3Egyz5YMb4ziPyP9PyoZbbLtKM8gT/82hiLKJm4a
         iTDXDcQFEiltS3o4AVjK0834yCTJYpIisdRlTm7EF4rpjz9/41fKIChpNrJ/HdyqSrvd
         g7aStCDFpJ/E0zljaYSnaxi6rluNAf0drcmwc6lECHYQfB0Kqhvas4A9lDq4cxQsd0Vo
         teXpABMj+SnZCHS5tXDfA6R3gYHhENrOnbBeH1WvPiPioXuBT/JvhdlckLkbGQyRFq2a
         QZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792804482; x=1793409282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lW3J89fIlZE1k/PGBlzPqSNLS0AejPIUQeZxW/w7Yuk=;
        b=SrFSijF5aH9txBVCthCRjO+mqJVFVEuAr36kMQhDlN0x10DG9Plx42xnJw/csi4Z1t
         FI9QxSRTIqizHV68AGX2T9rYw1IJUgqex9ecI6ghh+rGIqcP+q2O3VaJH0o0dFGaPVvj
         gph/AFbgG7zyWnAQ2rdLgoLRYP59kH7za2U6ZvnDzdjUUteS5TTHjLXa2/7RtnIHYe60
         ZGTJj9ThZql2SgwdfDCk3FZBLnw3ND1rNicmNt4Ifl1cl+e+FCLfIAJC+/OfoDkJx50V
         FUqUzvFm8c4UrAyUF15ctvA3kb/UXTfBp75OBQUSXhQfEvUnQpea8+6PZUi1jnrFublh
         JpcA==
X-Forwarded-Encrypted: i=1; AKwUvBwSnkiFOnBouoUJ3ctaDWInDslDzAqDQkf0/XuzcH/TqQZYO4K44L/sFViCXAy1GddoQvz6HYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXmepIPPIM5WIjtfOXhM3KgZDB9Jlu/HMm3BtM4zjhIIlf6s69
	mFwglcKCpEHQAPyo21nQ1JNgvv1uWUbiUCnIHE1Go1bvj6b8zkn56YOkiB2BscwfukbIPLxvNXt
	oONQnKQJLqKSW/bvZoAwwX5s/QPW+BCZj3F1C
X-Gm-Gg: AYBFou0m6JrA+2aT30r+DyrcYYaN+gDS8l20xDv/no+idmnq0/8SYjIBcCCs4mVX/OS
	bVZnT1RnPxn+r9HbLli1OxtaZHdw4dSaoUxXFI/qKVXzEluutY9MUQ11UdJGg974v+lSspZdmZp
	7ID8RV+GzufED5SIuXydAU7GqTPmy/nILG3/RyjMJLpL29GBBYmIBdNT1+KwbuMBcWvPIldT70z
	/l0RnJmWbQKpIm2kFpDh7I9TCINlfy+ZGX8o+/ehgswXemFU7jDN3h91F5mM4t10L/tJz0VI8Ry
	ClAOvXywTUnlGPEAcmNqaZRdO3swVq5oJAiAk46IfzyFqZhr04pSpudhlInSeHn7HRl1zzJ0+ps
	K64DcOZZB2XJ0cBIfHzVFfMkxYNHmr7E4Xesu
X-Received: by 2002:a05:690c:6603:b0:8a8:8f62:eb3 with SMTP id
 00721157ae682-8b166c81772mr5841787b3.62.1792804482650; Fri, 23 Oct 2026
 18:14:42 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023110052.650519-1-toke@toke.dk>
In-Reply-To: <20261023110052.650519-1-toke@toke.dk>
From: Evan Severson <eseverson@gmail.com>
Date: Fri, 23 Oct 2026 18:14:30 -0700
X-Gm-Features: AclHuK8xgnLqkOOBZDrevHzfPB7m2goFQmZThL31mMg8x-OpahF-jiXSeRKElKM
Message-ID: <CAPoPjSd_CedgO6ghSs-vX-O599vVQyEaEniWfz0QpmfmV2YGCA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: reinstate IEEE80211_TX_CTL_AMPDU flag in ieee80211_tx_prep_agg()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: Johannes Berg <johannes@sipsolutions.net>, Alexander Wetzel <alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested on the QCA9563 AP from the report with stock ath9k. With a
station held in power save under downlink load, the TID froze in 5 of
5 runs without this patch and in 0 of 8 with it.

Tested-by: Evan Severson <eseverson@gmail.com>
