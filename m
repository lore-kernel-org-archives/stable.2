Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0F6439340
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908477; cv=none; b=jqp49x2OsqS5DOciqjYiO+RIdgfP/R+YnegDGXEmnWECZRok7BS8c7/jyO8i9bGx1m0+1cf7iqGKcMXXO/fcd2vPcQ8dZg9OdEd6twEt25wO3rGhvPETh9tCTiZbA9efvtjBhPkfiTRMuN9+5MsHzhBEOdbWbPl7ia3GwQMDQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908477; c=relaxed/simple;
	bh=Se7Z6C3NvaFZx3sRz0ytU3sj880TltjWkiK2amoJliI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LWUsDJl9lYWGYwi/0ltTbbsn45/SGsvQaY73yLhkRfDvAPJNeHEifFCsejL+oNH7/uutUW+xuPQayq8tyfNLBpbZhhlGOf4B4ZAGXRcZX5sttKHAaoE2cLi3CHdqJQisla2XJPMeZRDeeAhscX/5W7sWHNgHAxiJE0MXYa3EPrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPMBmM6k; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPMBmM6k"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1832487a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789908463; x=1790513263; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IvU9MrZH0bJFXw2OOEigl0TEPTbdAKR1NNYjvwLoRhE=;
        b=qPMBmM6kNRgDZLye+o+DrwuTBpnvakiW0EudBHysX/wrNgJ73rPBh19b+DJ5v/gxfy
         8yrzDfYF58aToW9unNnRYTO93H4E5CjEKk/fIESeaI/JGO4cYrlt1wRUapnf5hb7guXf
         BY1bj4yhshq2+/92dN+fgIZNXqDb2+BQZfMpt7iNUlqWp2SXPLvsDJ1r37sNmNn7XBt0
         UlC46qxxoTg6pISoJUpnb27LeutS4QVWacKApOL+ZJr86968NmHql4TWV0k2VJP5KbDv
         AdDazLWJFgD67+TMCrsj0HiO04asr2c1Nrmgw8Q3ojsjOKm3L0q6bR+aL9Ofq5yKH2US
         qb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789908463; x=1790513263;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IvU9MrZH0bJFXw2OOEigl0TEPTbdAKR1NNYjvwLoRhE=;
        b=kJkGBBoeio0Qm+0iewOzBa8JGYeGpPaY4qWztXOB2Sk3HEr0jjXxrRtCQJWRsbqn4v
         FKj2eV9cBuS+3w4zv4zajzFI46pNVHthh+5E0FSGz1/cCId+fG9od7Dv/3OZ3+bzP6oN
         BYrwMlAdBTvAuvtmtStDyJCPSPrVy5lHyMYaPr4npqydj6muGrwOR+Urpg8VJFwkvMWW
         jNSGMWIg9d/X+pX6rKuVv2nRY5tKPJBYkWDhmyk+XeFJvw7BWo0tDZ1ynQNC1V13PL56
         pb2muvwPTXORJkrz3NnJaIZRJjGEw6eeMdU5nRut0Eqj4LFWrq9TND5HCSdxpSh8pGWg
         qWZg==
X-Gm-Message-State: AFuF++kz2eLKZgb7D86AXqN6oSFzhI8uO+3S0K77MA/WycuZHLmjeaxn
	di3pnX6ivh/amU8KNbp+qO4I0mJyoKwK+4o5jW9w83HncRDaAuDeBmvB
X-Gm-Gg: AYBFou2iplIXUPc18bnVJcR1eG4UG3BKgwny8Cf5l8jaJSXg6qIW1eVU3t4zrGXvcKj
	JmC6ZNC1VB3G9geN/dy0BmG1wSo+zi9r/kHsiIJoBsioBX8JEVViEhYWVi/BJZ5GD9kZkyv1vvX
	VbBQ6sAR9SN25xVTgVQ7pUJQ4hABsLfDdBmEPBXoGZvdqSFJqNRokoYRgSqHLtpdoZ9VClsPcd2
	AQRfJX7CjzY5k6PpKsKxmNKGaocQzUPGHgG0K6k1Aqf44HXD/bibEsASubW4BSOx054F1EdLbeW
	MbSvLphlLxtrQBM1xm4B6HrTR8fgce9ws5839FWiqcqcta5NJakS6rUbjOQ1ancrQ2Vk6xMDsCw
	ZA+iGVZeJEPQOtPz51/VcRACWmqJEKH12Im4r5qBGgTjFle2Ue/l7RwmHPczfN3fDYaXGYd8DNP
	0Kb+OP9qSuY8jiSBeDmYfKXEx3FsuxEObwC82VELWU1K/IbsfW8zYLKncYfnc98xreNeuGC9dII
	/tU9oLWf7g=
X-Received: by 2002:a17:90a:d888:b0:39e:4c7f:8b16 with SMTP id 98e67ed59e1d1-39e54cf8bdbmr13604077a91.27.1789908463484;
        Sun, 20 Sep 2026 05:47:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm9089410a91.1.2026.09.20.05.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:47:43 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 6.6.y 0/2] Porting two fixes for the cpsw Ethernet driver
 to the v6.6.y stable kernel
Date: Sun, 20 Sep 2026 20:47:30 +0800
Message-Id: <20260920-v6-6-cpsw-v1-0-a4a4b3dd4eb2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ6CMBAFf4W8s0tKlY34K8ZDrYuuByRdBQzh3
 61wnMlkZpgkFcOpmJFkUNNXl6HaFYiP0N2F9JYZ3nl2jXc0MDHF3kYKXMn+UB85hga575O0Oq2
 vM7jk8ovLpu1zfUp8/z9Ylh9bCd2YdAAAAA==
X-Change-ID: 20260920-v6-6-cpsw-a61e34586ca9
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, 
 Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.17-dev-5895e

A previous attempt ported only commit 0b8c878d1173 ("net: cpsw: Execute
ndo_set_rx_mode callback in a work queue") to the v6.12, v6.6, and v5.15 stable
kernels. That attempt introduced a build regression, because its companion
commit c0b5dc73a38f ("net: cpsw_new: Execute ndo_set_rx_mode callback in a work
queue")—which adds rx_mode_work to struct cpsw_priv—was left out.

As requested by Sasha, both commits are now being ported together to the v6.12,
v6.6, and v5.15 stable kernels. The only minor adjustment is replacing
disable_work_sync() with cancel_work_sync(), as disable_work_sync() is not
available in the v6.6 kernel.

---
Kevin Hao (2):
      net: cpsw_new: Execute ndo_set_rx_mode callback in a work queue
      net: cpsw: Execute ndo_set_rx_mode callback in a work queue

 drivers/net/ethernet/ti/cpsw.c      | 41 +++++++++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_new.c  | 35 +++++++++++++++++++++++++------
 drivers/net/ethernet/ti/cpsw_priv.h |  1 +
 3 files changed, 65 insertions(+), 12 deletions(-)
---
base-commit: 79643295eba17affbd16ca97f3ef04c90266b28c
change-id: 20260920-v6-6-cpsw-a61e34586ca9

Best regards,
--  
Kevin Hao <haokexin@gmail.com>

