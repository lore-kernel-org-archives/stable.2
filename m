Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647083;
	b=lADhUugLpOLEThkRofKkDOpnWtF2806ZEG4BiZweOGH5X5IBLs9QvIZLpxVhH/eE2/gl
	 IEPw+lIuywMogjA4TwHzHfut0HJ3W8WPkhBEcn36kEIDusom8Ho6aePGkFIiSArgjPHm9
	 +djEcV4tZZdpKwKE+7DGn6KuSsKQAm3HRR6mKQCfMkqySR6dHDfYzSHfLzloV2BchnCwc
	 ir4eILc/COz5gZ0H6XLNfyQLFOGKEdkWSLQe+2O52hMw+Bce2qbeMMUhHnE5gjlX3ZxFp
	 kzdGt7suC6DidinzW5VPV0Ty1Y0uuXvEnpI5WWzM9HG4qzScEHWq0AKF1yiPGUM/hBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FOqLSFlmXa9VNiEma0WSAldud1u92mwnEYoycTmoyt8=;
	b=Dm6rlCOFh/5JJ4bq0wUH/CB6GEt5/j//62599bWn9HCXOVUT1k6l8VaGPZjEgmvPsf7B
	 nhEDfGZZSAIrrFJRxoIwLCDUgmUhOJWY1uVl1yCp7dxoWfr9kptCGabgwzhfQc3RwYQPZ
	 /HMMw7le3R8Oj6REq+3NcDHnA7FY/GGt1ZoTQSyu2a/9IW3IEFIhnJN23UYrQ3bKwjOSK
	 RwWFnlEybwYWDFZa/dtBeS0czccd31LuaHr+f+Yk+dVTyMRu8cOVpt04Mprnrb65cUoTx
	 8eK+Ms/Uu7n31uQlVcMawfRh5IkDM+qBE5ZmaB2xr+/sHtH2OVBnejXYi0Y26yNbeDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhHLn3xy;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B288606A32C
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 19:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B288606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PhHLn3xy
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so22512085e9.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647081; x=1794251881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FOqLSFlmXa9VNiEma0WSAldud1u92mwnEYoycTmoyt8=;
        b=PhHLn3xycdnqVLb3UZxNFCI2+foitR+doRurslWo5zWx+ZuP9erhNAZazc5g1O0AA7
         X3Dj9KyynQ72xjN8X59OjfADJ4n8/IjNB89lhHSMIcWx9E+B06bZJh/zJyZf85Hz7VWi
         jEN2gJX70m2yjwrEpabO7JETQPqER6gctdfhUkRYvHjGFzm5T9Jl0xuz5CBEgPwNgfQ+
         PetEMH5SSAwzoMGT0s3FOrcikTWDIo+yHfkifKuKR1f+a0h6P/q/Tun6Q/0rbYobI3rp
         //3gM2yDju/NXhqa6VVeP0xHKMpS7vEj2KfNgt/mWHDl8M/CYit+OfEsHgX2YTM00UVt
         c+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647081; x=1794251881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FOqLSFlmXa9VNiEma0WSAldud1u92mwnEYoycTmoyt8=;
        b=xP3Xb2Onp8eLo8ZG8x/fdTr7uItlCqXJRIAP9xtXoQbpctWQ4FexfXODLT+hBaEYeS
         3Ydw4OvMoCwFmGfLlzALRBH4N/03zW5g3CLCkZVCmi3p0+uhBcUe1RsrHaqMEAAh4YS7
         SCiuF5+yVtp1yViRZKI+ChhrzTtks6HnQXwkW7bGJP0XxvMNDyWZqKsBztO2NgEggD8j
         sFaQnDs+7uxZo0Oo+u5ZMq+vUwx43Jw9Fmt/ffmWhwMDWcKuhopmOLK7SvJi2HUuXZnw
         GZASgHeF5ogdnqlcwwFKcUD965sk4EjHa+y2ajnMCfwD2yeLAR9Zk/tkqv0xg9z06FFk
         dDPA==
X-Forwarded-Encrypted: i=1; AKwUvBwsEiRAY9qINcPzmNxYOdtVP3e/KeOKAPlTGO4cDlQlqLVSvvsefqUOjV9YcCGvKLMYnPchpIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMTDw9VHl1KrXgW+vaKlGZjicrgVHhoDoaFj9RRVv4855CNC4x
	8MrKoLCYKwCuKhDp+C1giF5yEWAk04QO59OsiBo3yjczxXs4LOUUtxI=
X-Gm-Gg: AYBFou1Iq6Xhaf4PVri6XYPeZsG9Prl1SOgxNhJIGEJeU39UY64u/tYpBBYX+MqJGsM
	B94Jcaoz0V/ar4HHKtvR+bZ6UB8BN30kwSZrl4ZS8AtJPTPcA94QYVnpB6Kj2tx+3+BXaYj9yGC
	q6vZEG++THvdR+4SDNncUIAKHxhuUMl6fIb+PpeFAsRbBQKpiYDNCjWxeJGJKAeptJ9gh4Ea5AS
	Z618HXhKTxFMltQfhN4dbfYZNelKa4Z9v4+7DLvo3TQzr0thneosW2VVscJGIisrkM9XeUWv9vA
	8nkQaHGUVmJZPTi9xRPPfdIj0gBY7Zod4bSmHzqCQaqs+X80CtEa0iQ0W/FHtwV1k4QZUl7URI2
	j5Tv3iqJTzTf7Ul9noL/7PCRS3z7+zoQdednvhmSxw5lZZizVANlqt7T00KN67ZrGAMBoMI+xwD
	adw9+Sb5//0zYzX9RQJyZShjfWyJ3PYgJk0f938m8EBLN33Lni015TEVaPn4WDxvEqdq/bOTDqL
	f57DRvLdIecyHt8QesNFW6Xe0Bg3n70en5F6TxpdCYTbxaPI2t5nTlxcnNilV8iiasnNd1hM7BC
	+h37FHUa0bpRNt3PGxAwEoaU01Jv7NUY
X-Received: by 2002:a05:600c:3554:b0:4a1:e7ce:107b with SMTP id 5b1f17b1804b1-4ac150b20eamr267450095e9.2.1793647081411;
        Mon, 02 Nov 2026 11:18:01 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b9b54dsm21054948f8f.47.2026.11.02.11.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:18:00 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH wireless] wifi: mwifiex: cancel DFS delayed works before destroying workqueues
Date: Mon,  2 Nov 2026 19:17:59 +0000
Message-ID: <20261102191800.2309205-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
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

mwifiex_del_virtual_intf() and the error path of
mwifiex_add_virtual_intf() destroy dfs_cac_workqueue and
dfs_chan_sw_workqueue without first cancelling the associated
delayed works. Since destroy_workqueue() does not cancel pending
delayed work timers, a timer that fires after the workqueue is
destroyed runs against freed memory.

Add cancel_delayed_work_sync() for dfs_cac_work and
dfs_chan_sw_work before each destroy_workqueue() call in both the
error cleanup and interface removal paths.

Fixes: 85afb18621be ("mwifiex: add cfg80211 start_radar_detection handler")
Fixes: 7d652034d1a0 ("mwifiex: channel switch support for mwifiex")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 936939ea9c472..1fe366b89a2c2 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3196,9 +3196,11 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	return &priv->wdev;
 
 err_reg_netdev:
+	cancel_delayed_work_sync(&priv->dfs_chan_sw_work);
 	destroy_workqueue(priv->dfs_chan_sw_workqueue);
 	priv->dfs_chan_sw_workqueue = NULL;
 err_alloc_chsw:
+	cancel_delayed_work_sync(&priv->dfs_cac_work);
 	destroy_workqueue(priv->dfs_cac_workqueue);
 	priv->dfs_cac_workqueue = NULL;
 err_alloc_cac:
@@ -3245,11 +3247,13 @@ int mwifiex_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 		cfg80211_unregister_netdevice(wdev->netdev);
 
 	if (priv->dfs_cac_workqueue) {
+		cancel_delayed_work_sync(&priv->dfs_cac_work);
 		destroy_workqueue(priv->dfs_cac_workqueue);
 		priv->dfs_cac_workqueue = NULL;
 	}
 
 	if (priv->dfs_chan_sw_workqueue) {
+		cancel_delayed_work_sync(&priv->dfs_chan_sw_work);
 		destroy_workqueue(priv->dfs_chan_sw_workqueue);
 		priv->dfs_chan_sw_workqueue = NULL;
 	}
-- 
2.47.3

