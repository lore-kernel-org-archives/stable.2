Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619584;
	b=1MymwkZuK9JFnVA/YAmUIqRz8WPSMvsteH2Q3U/K5brB/iyZEXWmT3t9kzhRe6jirf7h
	 s6see3qzTv86QCsrE9137mmWNOrgOaGIe8C89eDvMDe3vIuGliLN0yWThbJ4yQC2BG0wT
	 H21PCIBuVVwFFRnJH8FjXmgdG5kvkzkE51OVgJ4fwCtxc4GCYY6aTPDF+HVVIhUnq+psx
	 iHrCSXncFmF/CFgT11j30g3KrKvPnhibViRwwbpmm3qsMIliygSlVBfJcVku/4ZMgQlFx
	 XBo5PZAnjWDvOgOltis82ppil16u69x2z25qF2qErRUoH1E09qHgAcmJHJ1LviM5G2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qe1rTWjqQDmAlXEufKG7vyV1ODzlCh2ivLyCCwvjgDs=;
	b=BUms9vcZkrcNr4rw3BSdlrPT00cHQM71p4keJ+Umdi0HwSKrjT/nObnN+JOMnhEuZOjd
	 hZKF/Ton40KWnBCe7eULGsDc2rrG6IXa0m5AgKp1CPZjg6K2lzH2L3lJGWnwxpR4yg1mT
	 j3X199OyOSqOAMg+Hu7Kp/yx9OZc7/cJhL08BR8ZiCKDOI35zYIK/yPw9573yDyBiv4dn
	 7KTtJhoE9xumlApgefi9sxCoChdWwCu94CpnFNxDGEhNwE4gPOVDrIOaaSQttE1jOT9vI
	 l5sI4q8WUCXjvBn9xUa9bJBH+cjBivjaeW/z0syiFNFEiat2jGrRUHy/GBWuzDlo6NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=In5rxvr1;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C014C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=In5rxvr1
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f269e335eso689292085a.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795619583; x=1796224383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qe1rTWjqQDmAlXEufKG7vyV1ODzlCh2ivLyCCwvjgDs=;
        b=In5rxvr1K9t/DCN0HToF/0T7HxYD4eZzJDCtOPRDBPdspZeWRSffgCUZB2Wmonnizy
         CwKh+oVaSYfQRjCrxM6W+7CuHRS1apb7PPP/6nipwztm9p2PPlKD1ixE5JES+H06pMCF
         /SWSVZUhQxJVEq00suZJi3ydJIDnduWwS5TbZEER9lcR/DOlXt1t0aa36+yJv672D9KF
         JknraiTprYYX6FnLtC8UrfqVkgfebrd+0YadQC0Sx4IWUpVtiN/P/XjMqS1FAzuE8Zqi
         z4A9PF02zhTKAg+jb2smgKfcRtxy5j7JiJayquGw6GMKA7jwx63FbY/upql6cyLTxmHP
         t9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619583; x=1796224383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qe1rTWjqQDmAlXEufKG7vyV1ODzlCh2ivLyCCwvjgDs=;
        b=JpNguEnmLlcLWHw32OYJInCAbj0QXjd64+DcQv3o/nD7xDC8vjqf3ycfuhPd3Kxmq1
         /o5KKvaLLL/NORsi9NWf5/vOOe9VXA1glF8SjBzcYxsOypBsKqGjckjudeJE3ZsumFPV
         05a8ALaEAUUCZyuhqKI99HjYEhw5ZK3ctAn9AMTD2hfazj08Ke4EmYhIs9EJmbiQ08x2
         t9uA5P5KCjM2d3SknRZqC9i2MIqGVdiE/QvRpVN/Vp9iCVK+Qe3A22wXpz8MWzZJ8nYh
         P7sHrA786nL3/H/2+OPMWvwkz3Db0ZM+leDk68lOYVCkX4gK41BFvJPsd8bDD/0oZE1H
         zslA==
X-Gm-Message-State: APuU4Z/Ad2vBpqe7nJ2q5hG7aRPIwgD1MjgjahPxhnFchGPkbmpfQqZJ
	l+vLso9RFbn8C64fjF0pnZ487g3SVP1VkyHMPsL2XoXcvowedcORotbLfc4id0Mb
X-Gm-Gg: AZFdTZf972k3AJ8dFZtik2m/kXwUkDNA79o7rd3pWeWteDp5xOAfCDp42iH3yMFi/uW
	AXDQk/ozcjJ/RWrz2buxt8XTdBre2E6dpX3K2A6OFq8HYslo7hYuWxVdt8gjkOloIQcMg9yQjsE
	GPsPFlKYmM1foBsy8q5D94H4StthfLyi9Vcu7cDZ7FbupzImAM6AUSdf8HmRNwJ1B4+6TheTa1E
	B+R0OCB0aBQdK9xE6lqMx05hf2x0/4KZL5bcTtx9SuXk5QpjL1NKV4t362YxvoiEKOrKV9y0ujh
	RZaI/wdP/MpRh0HZKwyJPidw4ejHtDtmLxVCUv7QgT/8Q5vSfAn3ye27xjpkE1perupKigTSFgC
	1nfFsUkidjFSSymJKekP4HAf4/azzE1UevtrlViisvsvLhW9YczOEKj7oPRdKU0txDURsiaSmTQ
	NPM/uhNsgrTcrFW8Uot/Ss9ksqarekMnEbxs/MQs2x8SqEQAHrn1m4LCvExs8K+rR1S5OKFb+yq
	SRLtGZaQqI2tizzIUyrUMOIsQDie34vGL1YLO8GNyZ/r6mExkThG+ygPsGEMNzVv35jdSgQqhbJ
	mIFBe6UtxVy9TtPvFj/QLcjUWAmIrKHehth7v+5QiOBD4gqOKSs8WQEegj3hsDdoCVjJv6gNSvu
	qn09WbNW7SAkeqRyUENkH77lVGToLdXY2r0gyglT46eg2Jkje78Igt04MWo2eDgwL/nd2MEvg4T
	cPXmi72PTOkJFeelRssn13j4Au5AzF/lQu2nwt+MV4iqpKAxk/iu/HwWW56khw1I0=
X-Received: by 2002:a05:620a:270d:b0:949:6d95:f63d with SMTP id af79cd13be357-949ba99cda0mr3291503485a.25.1795619582530;
        Wed, 25 Nov 2026 07:13:02 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949ca846322sm1155128185a.34.2026.11.25.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:13:02 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 6.1.y] iio: proximity: sx9500: ignore event config writes that don't change state
Date: Wed, 25 Nov 2026 20:42:56 +0530
Message-ID: <20261125151257.341838-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112540-shone-tamer-89bf@gregkh>
References: <2026112540-shone-tamer-89bf@gregkh>
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
index d4670864ddc7..1eff1c96e3b4 100644
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

