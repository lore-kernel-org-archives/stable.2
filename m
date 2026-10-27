Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100838;
	b=jxLH+IHL1SBsfwVGt/HTCtaatbOD5ID/CirYqGIi7kMYQLEQuHVBiRk/EFaRTlFDPI2/
	 pdTaYaqXw9F8u5ssEKScLKDN3B86Vs2s4Z4BoGYeel6W+KxAU1eVQWLBaxOZlNj3S1tgb
	 q0FKshTUO7JI5B6iSnOBEsJ0VBCiBo5g5rfK1MXuAIEM78d5Eh5CnZRdDhY5vyJ4uLjud
	 CyIV/rUDXemqrqZ/KEigcpaC85t62bmTaUHpl4MRfA+GICZFzjgM+4jzxfeilKF8josmh
	 1RQAvR3U21HJk6KkQv2SYxMqP7dIG45FvQQNBht+oGS83z7SkO/7GtlqFJZTu94D1Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100838;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=0Sek7EhtHIj1t/6WMQlwpjOQbOVwpC06TntZr717z9k=;
	b=GGCR8htWQeAArVW53d4YHYAulRhLMahAIzs1YRQn4I6FOIm6hiiDl8n/wVHkQmvVRyXy
	 z1dz4l+bhf1j2nbSUDtvxrJFDJ2G3Pp3pi8kFrQn3e8jZ6I/rCo55GKef/v6WwwhlJeMm
	 jKg1dQI8xocg5sWPZj8//V97zvA/c7myeBLezUd/TLWz9ZTPXuZyV8aO+SMB6Z9QEOO4p
	 Za2QAkvYMoHz52iqwngG2TxhDU4W/aBXDqt01y395M+jQ1mzjfU/SKD/2VxnMw87RaPCt
	 RWkuUdQUW6FYSIokzUoqIjBMt4U6mCSfsgykz9xn6SLzsJvR4+JPeqWCay1TJw+N6MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=bM+0I9Nz;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D336606A32A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D336606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=bM+0I9Nz
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202610271133541bba81161b00020767
        for <stable@vger.kernel.org>;
        Tue, 27 Oct 2026 12:33:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0Sek7EhtHIj1t/6WMQlwpjOQbOVwpC06TntZr717z9k=;
 b=bM+0I9NzL1IdWXMGZZQo+NKBOU6Trs75lN5klXQR35nQmhjlexau5HviPB0tLFecfqZ3Bn
 AtcvCnmSd2zcUy8+2QGZvul5hmpcYjTv5pPlCKyJRMq5Y3t6gLZGJftmtrtTr316lBSeNC2c
 RzDzrVILsKR3nSmGvKr5XrOa/dDava9oCAsmy8pZb9Ke9ZUoKMmSD4p32BE2ji04pqfzHQa2
 jgRv/KKL8k8I/VFcgHUvvw0YEcZMu5tK3Q0z2msKbCpApd5mOPw8BuV+3xlB3efFBRahigo3
 rQ+bNgZGriuHZeqTY2UePjo+HtdBTUDaNsJoljF6ZA56coM/ydr96foQ==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v6 4/5] leds: trigger: netdev: Report invalid interval to user space
Date: Tue, 27 Oct 2026 12:33:44 +0100
Message-ID: <20261027113349.383147-5-alexander.sverdlin@siemens.com>
In-Reply-To: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
References: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

interval_store() silently accepts out-of-range values: a write outside
the [5, 10000] ms bounds returns the full count as if it succeeded, yet
the interval is left unchanged.

Reject out-of-range values with -EINVAL instead.

Cc: stable@vger.kernel.org
Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v6:
- patch introduced

 drivers/leds/trigger/ledtrig-netdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index bf9a5ec245a43..b1f84014acab9 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -502,12 +502,13 @@ static ssize_t interval_store(struct device *dev,
 		return ret;
 
 	/* impose some basic bounds on the timer interval */
-	if (value >= 5 && value <= 10000) {
-		cancel_delayed_work_sync(&trigger_data->work);
+	if (value < 5 || value > 10000)
+		return -EINVAL;
 
-		atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
-		set_baseline_state(trigger_data);	/* resets timer */
-	}
+	cancel_delayed_work_sync(&trigger_data->work);
+
+	atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
+	set_baseline_state(trigger_data);	/* resets timer */
 
 	return size;
 }
-- 
2.56.0

