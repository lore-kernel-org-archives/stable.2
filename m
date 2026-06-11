Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532964A35
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137500; cv=none; b=BvJh5zu47dat9rDvEHVRIFrbjLaCSuB7YeeUdkZvZR+v/FGEHiit/EtzwlmTsVqFklyryVautkpNh0GA8Qy0YNekLQgc9FSPCiQSHekqgyT1ZpnshzRVDEjAh7kvuiEfhP/PTubhuvDrC1JYif0c3d4hq4ehAqOt61B1hQ4zx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137500; c=relaxed/simple;
	bh=xBE549hUxlfDUzO3UdRl+STPrbuxhOZnaaDsCdSdW3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FDMZEPJc+k0D3D9XKnIOwGLHpJN5Bs7tTAkOrSxd8pvHQmnpQzjanRNvLCZQS4/8cpqBduL59CCsIyco1vP3G0ZAq93iquayyIujT97VjJDL8j1gA0RArJA6Q+JcpIr3zV++dtwUkGu0TJrX9biwVLBZcXv0XgsL9O38+QDVK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v22s4GuM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v22s4GuM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13840d96f21so1406781c88.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781137497; x=1781742297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
        b=v22s4GuMHx7ewQN+DmpdrCx322JkF1v3bVQNAIUaGOoMoq969lYgq0XCWefMlagRtz
         rKMOPOeKuaTckb88RvCaRJcPYxgtwQ3QNlBK3NcGpHln1nc3dVyLpN7yluMyoq9SAXyL
         STZWvQ7p4Zjaq11kl1we2YgGe/6Z85WCl7se62o2pkGtr9GigxOcXl22Rqh4EiPFIlDC
         mVyV4hro3wUT6ZJ95gSpf/SWDKms2xT/XTvHC6C0vze1sxbDlWAzKLuwPZ67gGNIjDEl
         3YqFc/f+enotmB27hkLtxOO2CxGj/puW0vITYAXLc//efmxL9qiRv3KeNCGkCUinvUuk
         SI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781137497; x=1781742297;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/mNN+ZL+7iwwZTVcSxzEBAbL/ejYUDxYrg2Yjp4l8w=;
        b=rG8IY6JmJAnNmvTH2UrwQi24F8KEN1tvqZGJwQAbQBrHCZ/Ds8ujGynlFuVZk4mKvq
         bP2h/OQ9W2GWsTJls1FneVnBoXgHrIYOuEmBeaWRgaInbnUwLztqa7OXETR8dYW09W88
         2a1eqCJbaELzoM136B514/bcYG71U6zn+ATwxrcdlA3/5LH1PCPPj6xsopKoFPzo2qju
         uscGiPRBpSDQGt5rDJsyM64vklkfW0Dpqa+Yx6pb4NHqP0pqh9CB9OskrOeK2DjIqoyn
         /Rh2/1ppR9tJlnbUnM3zdr+Bnp/F7ri6Vk3H3RYaPjQwnoi6FmWRqv0vMKmXtfmhdOHb
         MkRg==
X-Forwarded-Encrypted: i=1; AFNElJ/lpuiAYLHaX0FB82b4CQBGH5XbUh8nK7NyxRSNJ07hahDpluEoB/30bNuDLWic2uGjTngcKWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Fixj9vSLLboavcMGm5xMylR2e8u4Dcj5kM8dJNEGUN8TfFpE
	nY2dvL8yDP9dbeJDyDNmR6v1rz0YnxFwzukolNnjxkWHI/lJi5jPXuVD/jizt5DB7L+Z9ykO2A8
	vTfm09ro8pJIZkQ==
X-Received: from dlbvv8.prod.google.com ([2002:a05:7022:5f08:b0:138:9f7:2b4a])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:50c:b0:137:ef8d:a58 with SMTP id a92af1059eb24-13842119f60mr288616c88.3.1781137497042;
 Wed, 10 Jun 2026 17:24:57 -0700 (PDT)
Date: Thu, 11 Jun 2026 00:24:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260611002437.1671401-1-digonzal@google.com>
Subject: [PATCH iwl-net] idpf: decrease statistics refresh interval
From: Danny Gonzalez <digonzal@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com, stable@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

The default 10s statistics refresh interval is too slow for real-time
monitoring and causes network selftests (e.g., uso.py) to fail when
verifying traffic immediately after transmission.

A 10s delay also causes aliasing in telemetry tools polling at shorter
intervals (e.g., 5s), leading to inaccurate rate calculations on
high-throughput NICs.

Decrease the refresh interval to 250ms to ensure fresh stats and fix
test failures.

Tested: drivers/net/hw:uso.py now passes
Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Signed-off-by: Danny Gonzalez <digonzal@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..e2890d219431 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1364,7 +1364,7 @@ void idpf_statistics_task(struct work_struct *work)
 	}
 
 	queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
-			   msecs_to_jiffies(10000));
+			   msecs_to_jiffies(250));
 }
 
 /**
-- 
2.54.0.1099.g489fc7bff1-goog

