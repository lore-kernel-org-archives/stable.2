Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5F44BCB5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515130; cv=none; b=Ze9u2VLz/KGDdPit9NdMtitowBGQ4f10vmcqlI+ZUfM7OxBLklfNTRf37wQJ0EfsuX6f6yRbV642dF+HAEmdJfem5d2/hzCzaOn5rQ6c6P92wbXIfU2fod3K+HfhbW6o0dYxgv+9c3LnLSy/m595knteYnMx8SZMLaO2Ig6KYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515130; c=relaxed/simple;
	bh=65nzK6vz1vgFR5pp0Wddsk4Ce3ZupOxMWzv5vPM7shw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUBMa8NWuGrxa/g0pfCtWtHtWf2Q8dXYWeDdL3vBOj4h86B09lH+ArSEww3voZHEGlnIAnu2NxKBG3/3KVD6H/jJ5T8gMFHuGdCEadYDR1QuILTUuOpvUlMF9tmIKU5Nkv70R4uKK94pZqtgyNI+hbbpth4b9SlZg3C+GF4AwV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-484373a2e82so312242f8f.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515127; x=1789119927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABcFiasFOwjIfnBE1VjTMy+55UW2Q6GZ49iMrPVroV8=;
        b=rYehoSocOmjZpH30uX7wVCA5gxowoF94Aw4SZJwHp1UnPWsc9WWPGEGY9CbJslsh6f
         odaMjrcV8ShNJMPw6KPoC3mDVqR/OHrtRSaQnOMpjoBBPlVw4ALsnuCfX3F0DGijAE9Y
         uHnVd8EUCfno8gCgStUH7TKHEquKJGakMO5SdMnRZQzrjInGsWYO4+ggnOeOPuUPuQY0
         iHbaZgpUPZLGGNJ8BytRRXyFeU9+W/paBkpANqn0SAEz9nLhiYtFR3VMXwpqt8U4RSBh
         qcoM2mCmvV3RLV+pfy+r++DCj6850Ju9LLp2t4PkkesY9Kuyi70wS60d5CPMh9OfTmrO
         3GxQ==
X-Gm-Message-State: AFuF++nmAhQmuGzgZLDbV6FiHLOL3jo/wZy9I8pbSQaXglJsiz6aQr6l
	J2tPvoklw8t94X1Kx87xy2baS95XAh800eBZWgkIif54Cqwgc8/F/bJQHMnXPbCF
X-Gm-Gg: AYBFou0HMoDvbBU2JxVD8bDx6IF/RZt4H82AQ/N/J3wFEd5DDiYm90/O5redGQs/svm
	iejr4XNrnnqrY4tahiFVnoVxtIiaM8crEkVQimmt2UhmuKXbgUegiqY8PuY+lAqtz1YV9Zc5KSL
	4Utu09JAKR6Qr9nEce2q1Fi7Nwm/M1DEMZcqTeFFKXxDoPrL/YV+mfnPfANkFm4I3X7nnlcIQPm
	qX1fV3tZZdtsJQzOVe3Y9WCL57ym+5Zn2/G5/QbnLTc8ekAQL8YAvE+1mzkiUSf+EvzQDIw20s+
	5p4tzwdweWxXuDKWLjh+eMJiDc6FGY60W8aeret0q2jFPhXelZXfgyQKR9Fsvyg4zxD1n8U7rxc
	iD20JvmAf8vebvwFELQdu5Oen0er9u4kMGbDqPEpkNG7gYr0HD/BcDWbkFU79ldA1v2+NDSHmyu
	m0JrpI8X3tHUAal5ZvnNzpzIUcKUH1zdJKcsX1jdk0PkmHGHVKjlA5DYVXVkXHNAc+luzvmIvIJ
	LeeQNBY7UzoB2PXig8=
X-Received: by 2002:a05:6000:4b11:b0:484:3310:c4fe with SMTP id ffacd0b85a97d-4858709b13amr10136390f8f.25.1788515126850;
        Fri, 04 Sep 2026 02:45:26 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588133600sm5632238f8f.5.2026.09.04.02.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:45:26 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 5.15.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri,  4 Sep 2026 11:45:13 +0200
Message-ID: <20260904094519.1817105-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090351-refill-bondless-262d@gregkh>
References: <2026090351-refill-bondless-262d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch doesn't apply well without the previous kernel-doc fix.
It seems cleaner to backport both instead of modifying the main patch.

Ilya Maximets (1):
  net: openvswitch: fix kernel-doc warnings in internal headers

Yuqi Xu (1):
  openvswitch: Fix CT limit teardown use-after-free

 net/openvswitch/conntrack.c | 122 +++++++++++++++++++++++-------------
 net/openvswitch/conntrack.h |   6 +-
 net/openvswitch/datapath.c  |  10 ++-
 net/openvswitch/datapath.h  |  26 +++++---
 net/openvswitch/vport.h     |   8 +++
 5 files changed, 119 insertions(+), 53 deletions(-)

-- 
2.55.0

