Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619600;
	b=bov/7aKvksjaoh4FQK/kT/f1EAj++4yTELOnVwCAYKwiwtaq7bH+p+uAFfk5sSeCmZBw
	 lsCzBRPegeJiyNcuh5XtWVOGOW8J1WkNYckqlDqzw3eiVuChbrj2wZvXExCluE51LRuvc
	 XBP+nS1mCYGifkQM3V5cm+zFYQ+q5Af8rFkxNH/GybFI1jiNSHDDOwDatJJqedZGL/Pzm
	 gZeQB8iyl5k2nMoH92WnkIwVCV++PaqML3zY5XD/VhnmBu131yqoWcfrWY4KH8o9I2Wbn
	 G3DtNtbpyfZAFr9VxcyS46Lj1wVuNmnIvmh2C/Kq+1wSCqm8SXOMQuDHcKTJuBc8bJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xgql0vXajBQ+6kOKM6XZWhi85Klf0AqDv/7L/9zdzXA=;
	b=PyuqJ42aJAiZXrvCLkWCMh8w53uHV4SH0IJ4qddc9xMU3RS7A7OI6UnGg+5jlm7xSoY1
	 wzoyzEUSGoUUhTTPOFKe0ERN62tY7kc0WA7o0ypJGRxNZ6NtY3IBFZNWRSeyMEr/4DWM7
	 EtdCl7B8LTTRFv52+ggNmuL6lpkznyIGDgu0EhPEezYWcWKDnQ5/9ua4ndHr549UgJBC2
	 M7iXvsU5/Bgb2rrs15u2vNREc0YIbRNOFopkhEmhcxNBZbWqjZMLheIgEUqeaJtdQ69ss
	 QyrQZm1C6AKzvDrLFaXQG+PZEH3jvsBgNYmqb9axT8HRGdqJZ9hoUButDGK3sYTCaCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHtRsbqR;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DB606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026DB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHtRsbqR
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9496577d4c4so657223185a.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619599; x=1796224399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xgql0vXajBQ+6kOKM6XZWhi85Klf0AqDv/7L/9zdzXA=;
        b=dHtRsbqRbRZ1aSHAfdKBko0MXT25N0sWThg89sTovE3g7v/GVFuz234fMyhQ1+KJ2a
         EHwkjRpxoNC6UfPq5I35m1TIPlD6I49tlsu31pd7Tcyy9zyuad2YXYcG8WVaAtPC6Ddn
         dubGOb/uRXG8xj2yE1SNd/MdpTUV2gSb1GEtE3dGTsyzdlRw3fd7Zv+bwYvpG38NczMS
         RXRujILdYfKdYZkdA/9elyWwIawXjoR1f6ZCxsmtDW/4VzjOyWWw3OKU1rAJYO5Nvk1G
         gFVRrT3LUbZ2Dun002/3Z3lF3W9qOUL3yrDub/XecZz3wu55Takpi6TYtxyr/7yjpivi
         8aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619599; x=1796224399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xgql0vXajBQ+6kOKM6XZWhi85Klf0AqDv/7L/9zdzXA=;
        b=laPEpmhIiS4q6dxHtHUaBnB96KFO7RMUIWY3mza08d35YoZze4IHibn7MhfeQNLH3l
         fHYqq0u+4xf8+aOyDEQZvQPias5sQVrZHbpoHLdY6HEUN/IXzbgM48rQEXe0RA3UlC8R
         VzB+tRYiEprQFkBI9NLW2217O6A+BPa9M18zA1oA2NdwclICQp1I1fTF3L+rKGQYMEB5
         kQ8ayJi8Dncht+Dkpp6xIFVAWfK+PcxpVgvGqtZO7+rYrqmGIUeJfLBHkQ0NjWthTkpR
         2khra5mci3RXEM/B5W2JQVYt+PjvYcVtZ5pDxStPhtClUzqzRHsG41bAlMd0d+vRPuOm
         TuGw==
X-Gm-Message-State: APuU4Z8xYbaEmPgC9P3GZ9eaNDt0S1WkRK072pF+UDJPRkOtHztgYTQ7
	N5pO3G1K1s+zWlghgPW3mHrw13jtiyvScTeu7psIrEf6357UV+WVg/JVpMGP6EYO
X-Gm-Gg: AZFdTZdZVYT68jsPRoZbomBJCir6lGe3YRL6EDiU8plaBH67qRI+N61g8JouHWSqNB1
	Dv1VKOR+1t1OScaxCyrjoqqm870lYAJ43L5eSGt7IiCzsBP3AuSlvLszZD2aPnPLhrargWn6INQ
	Z7vNe4JGg2StiWELwgkis+QIlgiZbKK/MYhviGpQc1hhDFm24wwq7ulmhD/jIyHGIHJGt3tXUR6
	AB9jXcPvIZTw3OEOoKM3+q6/2jAe9cIyHv43Fm/X6wRorNpjNB+r71oMJfGr3OFT+WZxF4zO2W0
	GaTEmSepUh/CYKlMi3AZRmZLp2b3jIHpWV57rfYfUrAdFQvpEwTaYlbAmhAh+1GlAtLhymx8crB
	hoXevprOQhllrvUM86UKnjFSB7SBIh+gulNXUB6VfGy2Hhg8Iq0m7uDnV3FIAF0iCWWFygU7qAv
	JEKrjTbB6rMIlQ7qUZRic1y+2hg0gOAn/yeLQZv7kYToF0AfSOfSDLT02CM1gqt8eYc/sNJTjyd
	x2qulw4Ntdz5fv5WBsEHzN/TSs2CD+qQq/7opzqHevyvGJ+UETpAbFZRAwuo4vrbiVK/UfQIA4n
	TwBDhkofuYpKko/CdSWDMk+saOSxFmqH1w7bYejM3sv/rEo0+vyJVkdtO+FlI6YiCpExga67EC3
	mWsUy7ypFs797pjzLkDBvgw9Eb5CsDXvI8p46hfdOb6PWbTEJOVaM06jSvt9jfqi1Rpn01yLyyx
	eFdhAGcz02wgXvL7czI17ptP5QTpSLIzuLi/kdaU7ptg==
X-Received: by 2002:a05:620a:2986:b0:949:aceb:b799 with SMTP id af79cd13be357-949b357272amr3329296685a.13.1795619598865;
        Wed, 25 Nov 2026 07:13:18 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0315f4sm1322484885a.3.2026.11.25.07.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:13:18 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.6.y] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Wed, 25 Nov 2026 20:43:11 +0530
Message-ID: <20261125151312.341902-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-saline-hefty-b6b6@gregkh>
References: <2026112540-saline-hefty-b6b6@gregkh>
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

commit b8ed9165906597b69a46fabf39ab41690721ebe8 upstream.

sx9500_write_event_config() adjusts the channel and close/far user
counts on every write, even when the event is already in the requested
state. Writing 0 to a disabled event and then 1 leaves the counts at 0,
so the channel and its interrupts stay off while the event reads as
enabled. As channel_users[] is shared with raw reads, those can then
wait forever for a conversion. Writing 1 twice and then 0 has the
opposite effect.

Return early when the state doesn't change, as
sx_common_write_event_config() does.

Fixes: 4193c0f1d863 ("iio: driver for Semtech SX9500 proximity solution")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ Context: write_event_config() still takes int state here and tests
state == 1; the added check is unchanged. ]
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9500.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 550e7d3cd5ee..3264166c9fc1 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -551,6 +551,12 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
+	/* The user counts must only change when the state does. */
+	if (data->event_enabled[chan->channel] == state) {
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (state == 1) {
 		ret = sx9500_inc_chan_users(data, chan->channel);
 		if (ret < 0)
-- 
2.53.0

