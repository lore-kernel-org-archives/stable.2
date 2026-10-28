Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197127;
	b=jmY65mLyDK0uRxHA3VI3B+sawopaxCuoP6O6BnmEFgIDQSowHNQMCwkJOjW2y75Jwg7V
	 HPzlALUAEYVvCq/7RW8MhGao5xd+3Z2wD6thJvw0UDI/tpm907Doj+zYxJot6PGXF3Dor
	 /vpwJZVHSYEMPyGPzsnG2aJIt1NbXznedZONTGN7KLM05F80er1C550R0b9mB44QQV6Rm
	 KQitlB6zgyOT2WsZNxvfSKmuUD1ZjckFfvpDCumS198WaCdapTXDVVeppRgQuJFY6Rlo1
	 IHVItZCe9J3SqBUplNJJg+AoVnjuVwA0OBiMk0XAfhMsdnDyTyCOMSgE7jeq/KpkRQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197127;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=x5pMrzNqhnU/C2P6XLQ8m6/Y72S3deTQkrwYq1kdoTA=;
	b=CzPAFLQkZWVzWQ1BSJTUEmmHwmJfK9w6ZyxgKFY+JoG/ySOiih1fJaJ9od0/h0NBE6Sh
	 mCjvRmy/A7pBzacmgCJmU5SqeGvF6R+RvSVMMPtznXydb+6faNKu1QWGmU7dmLXAsa5SG
	 93/cw1v2tdHgiL6Zs3ZkyUJsMqbJJcqlEQn6k2wNxecieJa36d9MLv9VmrfEcZ9A8F8vt
	 HbOvhIk5/VLKpui8/KkO4rBkeNZ3m1I/p52psGsWghn90CejT3hi8iaQhfHCPpvP0d3ve
	 XvKDpdGng+kB9MFn7F/iSnfOO4cF1OGPvi9gxsa4/Uv2R8Dzq+slhL0iRrKex7SjLPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7TLlDew;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA09606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA09606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D7TLlDew
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso664140a91.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197126; x=1793801926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x5pMrzNqhnU/C2P6XLQ8m6/Y72S3deTQkrwYq1kdoTA=;
        b=D7TLlDewfvGsFRADJTjmPF8rrR4n6LzIhjICYp/le+3pDRjbxkiD4agzf5lGE7L7ND
         YR0c6Y1GYict88qgmGuJFRmPWpJ12Z5k90qpP0gvG9o5eXazBhdgN9mGxuEh0bAJuu7c
         FdK3z4RCRPFa6tTjPWCYRIBB9qhxHMaqiYS2BQLZ+YSJfQDtW9VZIDblnPsOFRInnDbq
         mpth9IY/s1EJ3Q5oKkSz5RLa1wlru717pLCc0xzU5BE8nHJR0faQRHSl3Q0d4U5tmJzi
         3OndwlReYc5K2q2wXK1BkqnvkmjjeGTyspnt9Kn1T37Cxy7XuABQhZwNDcwwGFd5q7ZD
         zG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197126; x=1793801926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x5pMrzNqhnU/C2P6XLQ8m6/Y72S3deTQkrwYq1kdoTA=;
        b=LY9COSIfo69iUGecdDN80CX3gmT68gKxcjoVoeiMvGPUm18iIzt3YkQvOseiPfamQu
         CaEPfsCNIlwCYeeBfV1R91tQsYDHA1c92rwjBu4PM9VqHI+d5bkMaD1AzWpq81gnD4RA
         R8NC5FXXGFEktBWq7wJisS8RJ4kw1reuTX0EftNMMRatlJWbcPl4xfogtHanFPLisVE/
         HWRBlg4vPPIj4x95lX8thGUrDRyV9B28Pcb4ISW+tV8rKhLTB5qX26tnulGyBcVFC2y+
         l2d2jZNSNdFDR1IFjIkNT1TnvHT3FqDCM+tqw5aFqll3BVyPHg1JStzXQI6ylhx73266
         K/tA==
X-Forwarded-Encrypted: i=1; AKwUvBxF3no6uWkGRj/enA2jumE34vAwRbMJhM9eGPO5oaG3jy5NfP8M46c+NWQa9gZvQWVX7pVE3ZE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLauj5Ecxbd2TG11QB/eNEkS9o73HRNJzltKWfzXuzm9iVsaLlT
	eaIR1daeJ2JUtxQpN5POxw1/4AmKFhg1b2HMiZ7SNmkxu81WVFdGlX9t
X-Gm-Gg: AYBFou1dPlco+lBHXRZ9PmWXySBc4lt/rAhpcjPfzxeRtxMZXX3FvhHgcICDy6hjsmM
	JRh6EGbChFAapPTw5mlRcyXs44x0Nzyj4Jbx4jr8ACFH8Gb2CqTwrNGdq42ZUJs+Ysh55tcy4Hq
	7eZyBznq81MfUQMX/waOSiG65x/U0rAcR1L1HVP9Hb0DnRcrAoySCQuMtNHDegH5YINbuTKev7G
	Sr9OV4/LMYrNyFscGGJwc8ptTxLbBPNvUlDa6an+JOePeyGlubTB+doEtwIsU+qiDd+XRdw2Yh2
	czC/4wdJCa+S0bTrBB3RoRyszElBY7UVM3TNzQs+UI3sluqOqJUsue1dCZnUsFGVN4CvWhGlwKf
	yurNyhCQeqg/XlGLBPfYpVVb9cZqIHZZE8M2P63p8ijyUfIydZFe31L7jn13mKHUkk3GIKhV8bG
	Qv/1w3EnLC/QLDegHlDrEuaVtVfgftdDP52Zv0FCHXG7EaFpH+WLF1ic3Rb6sM5UVdb4Kxdreet
	NfNrtjfi+PhEim++u8QF+LC2e5+u2vddHjhZ8k53UlXDBnYNIxNmWrp8zRYfbjxHPhohmrkAYwb
	GB8NZMQBPqKzpxiK13ovfeC4/m/vu50018V2uN4zOim1pz4RnXfl2R1MtYcJs6AGIbShyg==
X-Received: by 2002:a17:90b:2886:b0:3ac:9d14:feb2 with SMTP id 98e67ed59e1d1-3ae581d5d09mr1702502a91.35.1793197126435;
        Wed, 28 Oct 2026 07:18:46 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a0482e9sm3437223a91.0.2026.10.28.07.18.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:18:46 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Linmao Li <lilinmao@kylinos.cn>,
	Kees Cook <kees+treewide@kernel.org>,
	Rosen Penev <rosenp@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/4] wifi: nxpwifi: cancel channel switch work on teardown
Date: Wed, 28 Oct 2026 22:18:16 +0800
Message-ID: <20261028141819.7556-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028141819.7556-1-enderaoelyther@gmail.com>
References: <20261028141819.7556-1-enderaoelyther@gmail.com>
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

Stopping an AP while channel-switch work is pending leaves the delayed
work armed. After driver removal, the callback runs on freed driver
state. If the AP is restarted first, the callback switches it to the old
target channel. Reusing the interface slot can also reinitialize the
work while it is still pending.

Cancel the work when the AP stops. Interface deletion, type changes and
driver removal all stop a running AP first.

LLM assistance was used to find the bug and review.

Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. Not
reproduced; IW61x hardware was unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/nxp/nxpwifi/cfg80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
index 473e81304ca8..384ba69dd058 100644
--- a/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
+++ b/drivers/net/wireless/nxp/nxpwifi/cfg80211.c
@@ -1638,6 +1638,7 @@ static int nxpwifi_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct nxpwifi_private *priv = nxpwifi_netdev_get_priv(dev);
 	int ret;
 
+	wiphy_delayed_work_cancel(wiphy, &priv->dfs_chan_sw_work);
 	nxpwifi_abort_cac(priv);
 
 	if (nxpwifi_del_mgmt_ies(priv))
-- 
2.56.0

