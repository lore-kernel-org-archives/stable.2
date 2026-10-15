Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DB3DBD51
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031733; cv=none; b=mM0wT7AoDmc6gmceBhUcsnFEE+Qe+CZ42i6tStHdpjWhdiW84rDTKLpa7/diqcal8qxfkKlFXLFBVROITDTqldzGWpZiIwuQoK3M5kEWJoNe2aPWkFsoaBVZUGc8fEd5F8uxc5TWBIwnRDq0lx9A2MnpcYX/UDlwmrE+8eT+6qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031733; c=relaxed/simple;
	bh=HuGeJoAQEA7iwbIiLxJv53njPzZ3n0LkR9Yw7d+krrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl0KNcDrPUJbWpQGKSAfJiF1n/GKo+3mRnBygDboxL6JuHr1/pEHyMr9oMXR170aqidN6P+3VG9PwNLAwkKnMX2yl3CsaywORpaPKGMkcCOTc26WwUmH61tC3fCWm32b0UjhH2+JVYsvjAZrU50g/z8p2vdDV3TtWPLq7pr6ijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFO3X0IK; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFO3X0IK"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd3310348d2so3199055a12.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792031730; x=1792636530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuGeJoAQEA7iwbIiLxJv53njPzZ3n0LkR9Yw7d+krrI=;
        b=DFO3X0IKNgTSyoBkih4W9uj9sRv8v+MhgvfHjvQzJNayEqXQy4gKrHyjOjIPusKzgA
         hYrvLT7TZY2Rbl8m+sT6+8Svhqwi+ZS/dqeuW0GhThqGjYkVvEb74eZWh0gYYhXdUnQK
         /ba3qCIHaNPEN6VcsAnVTxbIp77nCAFe06twS+E8HqVJsIrHmcQS872h/D7qroffARqx
         dTI3tTFvB8D+XqMR0dilPvvF+MPlzQ1LSaGChNMlxzDciW752vL47JU60UdhAeM/CC9u
         Npas3LQ5C/UDFawFjH+pZMdA7LP+EOp7vGTZ0JunPtOhF7N4W0rVhkl8Q+Nd54sXvzNa
         o2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792031730; x=1792636530;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuGeJoAQEA7iwbIiLxJv53njPzZ3n0LkR9Yw7d+krrI=;
        b=mPzifx09RW5rcegWk5xKqukTa+cEX3yCsFZXMSu+8/pAf5Z/YW+qmOIcSy+UUhVKyG
         V04LtnAtXbwEhMAa5fYDR1TGG0zITDNMBGswbgrNG7hdDc8QnhZYQBeM4HPUjYlxsuvE
         WdPt9rMl/Z39BIGonl+8zHE48ggE2WULAmh16wKYcCc4p901Ew5GRaIXAlPkV5NlYs38
         yPNLGh3X5r7GVVwuhUrdlFy/ZUc3BEp83uZa1bX6JOl3eLzJuEkoba8vbekZ8aazDAZh
         pxna6ltzvIGMbhjoZLf5of8dSDlwqcyL06H7up3q/vOh0+Qi5OSNgvIaAaibp/AtaKNj
         MYRw==
X-Forwarded-Encrypted: i=1; AKwUvBzT7SUIIhLoNM1us19sH5Z5A/KQHnpNsn4dXVUjYyB6MnTm8w7FBKyTlIfA5DiICjlv6cjc4lk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKurXHEQVqOABSSeQp6yDRBJExB7vgjGCEV/dASjLjVsUvSyDU3
	OO3rTvwoWaagdVH9+RxV8ouhWg3n2wBWtBF1ZH0xCYsUTcPu6AOk01IA
X-Gm-Gg: AYBFou3/HRGF3fjWy8ohkCzQElkGTwCFpaKfa4RbjlO3cBQ10ZH1B/cveaIrRegg8bh
	b/RgPKmWgbnCkLAeNu90sqKQ2NfRLj2PTmRZ0vRrcssFbn1EoDWLQJS97jgD/iAg4HlYGYOs/7U
	oi7H6xIm+zreg8c0Ybe5xbd9AOVvbbB2e2o8iethPhqmXuY7bz4YQyi4Sj8Ip6xq0lVoJr3YoZi
	eHZQWton+LGVBwzMjq+vuVO6iE5RwZPu3GjadHAA4fhAyKj1lPzjw01Xg/zsi6JEAXHx7tM1iwB
	XisYjCowJ5QHB+eQprsW5g5Tkn013T1doR+w5c1bA7KThd2/KBwXIfZ3Xp9qIAR5S2mu2Efg5iB
	wJmLZvN1DpFGi1xQhmMH6cDN3Wh1QNeqHhP3gC8Y9vC5av2ExXsEXI6gdUAtUFEGmwMYbaSLkrX
	IKtHUGm1w7VcMqNI+ZlQAgVoH2ADjgrc2b8c/CyX/3c733sVwNtM2X3GyFQsvaeO0=
X-Received: by 2002:a17:90b:1844:b0:3a6:d2ac:74ce with SMTP id 98e67ed59e1d1-3ab3a9a8da3mr10311790a91.19.1792031730350;
        Wed, 14 Oct 2026 19:35:30 -0700 (PDT)
Received: from ubuntu.. ([138.199.21.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e821csm1940875a91.8.2026.10.14.19.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:35:29 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.com>
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5] jbd2: fix shrinker scan budget accounting in jbd2_journal_shrink_scan()
Date: Thu, 15 Oct 2026 10:35:23 +0800
Message-ID: <20261015023342.ping-jbd2-v5@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001-fix-jbd2-shrink-scan-nr-scanned-v5-1-5348b51efce2@gmail.com>
References: <20261001-fix-jbd2-shrink-scan-nr-scanned-v5-1-5348b51efce2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Ted, Jan,

Friendly ping on this -- it's been about two weeks since v5 with no
review feedback yet. This reverts jbd2_journal_shrink_scan() to the
sc->nr_scanned-based SHRINK_STOP check from v1, which Jan had
reviewed, after v3/v4's nr_shrunk-based attempt turned out to
conflate "this batch was unproductive" with "nothing left to
reclaim."

Let me know if anything's still needed on my end.

Thanks,
Qiliang
