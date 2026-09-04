Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32A3B2FFB
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515316; cv=none; b=X3agkRzaMo3jTxtE0yeb6P8FSE8E2jUzWgQs4JJZJzsXf+cjPODctFRVFyeVOLBnuWreL7v7Dyb45wb3O2Fxpzi+i1Ub4tHtnhgJEFOl9HnU3a+U4ahFygPcDPCqFf6i3ZOKV1/QzLbwcv08v2eQdU9DV2dQdjYr53N7AzYYpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515316; c=relaxed/simple;
	bh=65nzK6vz1vgFR5pp0Wddsk4Ce3ZupOxMWzv5vPM7shw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP6Yx1nDzrSUz6CL1gAdKPlYU6sQyQ055obMFOpb4OLF1G8v6HuCug1Up4M0nC3Y64Himv82ltK/5/rGlVmm6vdwqEtn7Ok4X1uyl5Zu7Kgc7BPGuHwbruvqsliAP4rDSHy2C8b/wgFdDTeTlWusYQsnoChCwmTiSRhhFqzXMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so2471395e9.1
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 02:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515313; x=1789120113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ABcFiasFOwjIfnBE1VjTMy+55UW2Q6GZ49iMrPVroV8=;
        b=JG9rMh58+U1F6Tpo9gk/UlbJ8SVrtPKjPDLJbrZI9IZFG3Nh4Kf7/Kd100O9vX3haj
         ilaHAAR+RSJg7ICwjYon9hxAvizisBTGJS3yx5Vgxl7D/07sO4HXf+NH5cm4Xo8MoSB2
         ldGeD/gWt/UI+V0vwJ7/hgy5/qtmDMRMkL2PS7gPZoD+hmZ7fw/yR6UxXX2GXWrdtE9A
         e5adyPX6mGMSnwX8+vOyjLq/VrgfeaCRmpZdD+qP2K8RnbXaBkg7+A3o1dB7DmQEtP+h
         PzmBJoQKaXhAOMkDZORlh+RofXui+6/lxIMW474xMgBHy1uUckPV8TA1WldL1GQ1imo4
         bllg==
X-Gm-Message-State: AFuF++kjfeg8yOSHqognjni3gw3nbb4B2WRplEm7fH/T9+GK6b6YnHkt
	dZErvEB3eAB/rJRV4ZFcTdzb/CnTP09a0R85PE6w5TK0Qz7uNfq4sz39EjvOen+v
X-Gm-Gg: AYBFou3bNgz4j9VKXz1mBLsQnpuVZXUZvf9WhaDruHSD9jbQpKSR4tHeHiLx/v7Fntw
	jLE0wWkVpxObu5Yzsj7ob58wcvpWGUl/LQ6SKBtzeVxdHkQkZ8fTfA0rcUSg1s56eNCnHsd15uF
	PMGyrtFoSoGuEhvir1QrwHVAygUJMouK6Rmty9D4m9xcxZ/UKhKhIhlXXQU5iCFgSB90AAF23t1
	BP3zxYIBM7blEXmJTxm44l9Depme29vAn4E7DquQQ0J+qXAuxzIBr/hYFjjo5K9FJjIAfzZQ29B
	iMIjoY6js0PErQAhxtiIuqRyqJEL7+nu+V8BFqw5tAjzV0clTnQJvAJ3xFmfsCHCzD3S+IRhMWh
	cW3wBHoTN9TBEn9Cr1Db2aZsDeZzX9ZV7qoJNBcrTeyNO2Ii2Z+ZtaNBYgDAwWtL8EtsGpcWUx2
	Vspv5GvnUFZy5otd4WKIHjMs0QYh6/CQr9fz0W8wOUUGPDG8tz5ytlGGvUg7Y7a1zzSHHMV2Qu1
	6uXed2YP6hdOXrDOQQ=
X-Received: by 2002:a05:600c:4e0e:b0:499:bf8c:cfd1 with SMTP id 5b1f17b1804b1-49cf81e6063mr54565305e9.2.1788515312887;
        Fri, 04 Sep 2026 02:48:32 -0700 (PDT)
Received: from im-t490s.redhat.corp (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm145501045e9.6.2026.09.04.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:48:32 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: stable@vger.kernel.org
Cc: Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH 5.10.y 0/2] Backport 'openvswitch: Fix CT limit teardown use-after-free'
Date: Fri,  4 Sep 2026 11:48:16 +0200
Message-ID: <20260904094826.1817930-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090351-garnish-ferocious-2169@gregkh>
References: <2026090351-garnish-ferocious-2169@gregkh>
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

