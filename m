Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4A392C21
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116654; cv=none; b=Iyvhq6Jj9ov8Mv8P1aqd/aKxq3JaeO8YfruSSq6yzCKbm++kmSl0sHnMHDb35o93P2Ii+iSOtLHJ1k+Mlx09FesHz+wmOfQRZu4jRRsCC3rNRblZp256IRlxFGqe/Ix6mm7+UWSg0HExesctoyR94sxxRyVBgHwrjY/CHp4Y/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116654; c=relaxed/simple;
	bh=Zc1KZBlT+3PtjTuluFVY7wJcEB53Glf0TXffmrReo4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AO0GSE4UANi6DS3nm7haMjYcnfve9AUpXeQvrbI3JaSiWXAxml2d9ACGaQAbJ83zDwMUUXizqZc2d6QYxarHd/4vOklyPhR/DRhRQ6qO8tIPYgyGUjhOlj1O0yuMCi2Y8v0QbbgSJpM0NkXMhNj+dIJilTA/tVkTKeic5phdHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=KMVjoYoe; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="KMVjoYoe"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so2021423eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792116652; x=1792721452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zc1KZBlT+3PtjTuluFVY7wJcEB53Glf0TXffmrReo4A=;
        b=KMVjoYoeQyigM+VZH6XAcg5wqw8j9cioBMRrldBW5lGSfcFuIKXKuiZz5wte/dOngr
         b6WBk7jt32ibmKmqP2HUTh5zN9iI2uWYhSTj071OHXaL5YyGaropb5pjQlgb/tZgOMjC
         5BcNhIW/qFxUFhxkw4SnUU40ki6lxxqhEPH/iZhyQYQ8K0J7k4QkbX8/GjBHQWZnXFPP
         1h4ZBy4j7LfqRPQYv5McGmeBGM0clCh6GM3Wx3g+f7XO6vKaJoYHS5Vl/vwxKekHKlbp
         hy/+FCRTe3zmyqepvwn50W2L0EDOCRU4QDUP8/4Gs6plfbZ3+TxxhNsOBuOXWKudlz4w
         n97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116652; x=1792721452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zc1KZBlT+3PtjTuluFVY7wJcEB53Glf0TXffmrReo4A=;
        b=atdM4zTzmoULYe/PEkq1W05ovzzRZW/eV14WetdW92u/jel+dQPtWW20QmM6rhgu+l
         J3UUGihrOvRRcvwtgvcE0zJfmoDelY9AqnSHropiFeT66qerHH/s0tSHOQUfnpa0t37D
         34CnItNADlfFg3OBfD0yju8oFRd8sMbrkV6jk+32NKmpWCXvMV8+2rbLrwBzOV7ZrOyv
         B6XVA/l0wdQMHpdQhIa7i5XWuziERRDVvwmNEp/Q1tyGpGvemp2bXEKH8AKSx3ep+Qnm
         9mgvZuqoMkVgBLNN4MYfovTpGiLjuCXPeFkjO0Egz/KdkCswKgrulq8dfdW51hwYIjsh
         bH/Q==
X-Gm-Message-State: AFq9FYK3c8neyBzTIDjEzCrV+nuH6xqwLMtoIrIhC9DhNW8VSRbcjmdY
	jQ8Nmq8kIRnje8mOGWQGBd+U0co5CXdntANrqojJhE3FIUjVV+GALK7avA30TT9fn1yVNUVvKbI
	eF4Of41hxMA==
X-Gm-Gg: AYBFou33dSpWvKI/e15M1eXALDhPvs7MvXO4Gcx1FXpnc8043sP3dEp+Too+w9Po117
	U+7/nyJlmbL+Vnavh6w4FOiKaxx37MMOZhUmJKFJ/ts2I9Eq77R1xGPl0QtLjd8e/sCmAXcTOdx
	WNPYwFzIrOYdFpIFqKBgjmCbZWPrariFt2FxsYAZpbA2tUi/3aPFkyqgCxEx0C29ZmIpA/iTfi8
	xyy8RYm1SWxQINIxons9j6pWg3ulTEt+urNIWaXVmiBHNwZ07wj6BfXWstOL9ty14+SNXZ8JtvI
	Oz5AAtMVLq19mCZfYXqXVre8HC2KZK3RrSFpsbJNYmj1Idi6CeLs4JQe0z0O0FjAIiZHdkS0r16
	6BTrrjuy00JcljLhCtAkB+LMVw6WvcjEIcPYKx5ltKUyuVc1JeWGoQDr4RbDECaYd+DdKezJsJ3
	DBfwMXSMrdDVNd9V9i8bXzL8MVcfcb/EO37hRWevS4xemJxaMEnuJSfZxSeUNUFz4AdBD6pEkSD
	mTrXh1phbZuDn5Levud3lh0m/JJcQaCQ928YRfgAOp1tIcIt7+TsdgUqiJvVBmB3HC7Tg==
X-Received: by 2002:a05:7301:103:b0:35d:f7f4:bc1c with SMTP id 5a478bee46e88-35df7f4bd83mr8817165eec.6.1792116652320;
        Thu, 15 Oct 2026 19:10:52 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm2638280eec.28.2026.10.15.19.10.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:10:51 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: halves@igalia.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	luiz.von.dentz@intel.com,
	marcel@holtmann.org,
	ngocthang2710.1999@gmail.com
Subject: [PATCH 6.6.y 0/2] CVE-2026-63974, CVE-2026-98297: backport fix series
Date: Thu, 15 Oct 2026 22:10:45 -0400
Message-ID: <20261016021047.16461-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2026-63974, CVE-2026-98297 to
6.6.y.

Apply the patches in this order:
1. Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close (fix)
2. Bluetooth: hci_core: Fix queuing tx_work after workqueue is drained (fix)

Patch 1 marks the workqueue as draining during device close and waits for
earlier RCU-protected producers before draining it.

Patch 2 makes ACL, SCO and ISO transmit scheduling check that drain flag
under RCU, preventing new tx_work from being queued during close. The code
changes in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
