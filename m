Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413925;
	b=UN+9Ff/sKr1nLkXFAN/sj8Fa/+ljdVtk04NdUcpSOYjW+l/JLrTC0VGOujekP6XzrKeN
	 VqFaPn3xJiPeVQv9bpaMfNT5RS3MU1g91CLbli2TAdirYPnOmw0N05yQ1J05sMcqYluKk
	 XWRUYK/n7wHDLL420XJBZii7ckmFyDvK7IVR0Qn3HOPpTRT959uUdNIFwP7R6/ERQv0qO
	 9sKrarcHRRNcleY/lqov0lwSFUgmRVLwOC2sIQnp6OST009181nA6cYjM9krRf+rzX7/c
	 4n4oDZFM1f67kHqbCJhJBNJzKowwSm+KoOVMCKt1H9zHAFUk9T8DZfz0OGvwHqddOrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SQTg6mu9eOLnWguJd3WECuqCcHwaFD0TQuF9ZQxG35k=;
	b=B0hyJXbhediCKiS69YL3OuQFx6Lskx+ClDwn3CbiyyFSgIgjZNflHreCN6Zn3oifIr/1
	 crzTg4tGe+BkQx9qADbYeKJgM8KgM41Gcp7NNDmayMogpke2VxuDPVwjk4XoDYHum89/S
	 gluYqfCIC4+3aJtAZEO68E2sIc9u9AaidHCNydpqhgMABfcwEJBpegPin7E4oImjDPMpz
	 sJljX22Q4quZtCslSzedfGCzm+1hDKbHg1Z3/NFFNg6MIei6VRS/1J50obqdyxqzcUnnd
	 AdbS6k5P+AZqQVMQodA7+HUL2onCxdTbwL3gMvoxDCTx7by18rvHiM6lIYZRpbWfrHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="L28Sy/53";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228CC60A383E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 228CC60A383E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=L28Sy/53
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so1692096f8f.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413923; x=1795018723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQTg6mu9eOLnWguJd3WECuqCcHwaFD0TQuF9ZQxG35k=;
        b=L28Sy/53fBIDZZA5JNFU3qj7CHWSZMS6zMvqhV8cs690h/ubOdtBbR3+T/B2a7JVTk
         rVQVjtZ+HqfCHbRp/0W3IInVub3vTTcOBJt8pKiQmJO2Ber1TGHkM5n0BVt2BU+d9Ary
         aavTVlcexyEZgM14fKIqNkE/GB45NFm9ffMvANhq1eJRoG2uv2PW3l7E5Bwq/W6assIv
         ZK9Y4cPi5d2/UR6x4cWRCzl3aK82HlMQGOCtZY9uEqEtVmi7T0mMDSY9bkKbKo+cnCLo
         7ZzDuiGmLS4CMjK05w8jpB1fQBJYi48vr0kfClvaYl7dc4aZfhNgZmNnCoEIR78ktG0k
         wj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413923; x=1795018723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQTg6mu9eOLnWguJd3WECuqCcHwaFD0TQuF9ZQxG35k=;
        b=wW/zHIDDMbYIDskZBK7OoeN5b5CE5rAihXzUQofEKV+7qdTbLVdjNWSjtflx4Bjky1
         5R5UoKnhnhQSsxfkO3DslEXZOZCP2WFUQOBrs7+f2AGkuBkEbi0bEU3xzGdNRWUfe8im
         R6AMTucfeU+UTrKlos6igfoWOQVjKAUeCvXMYiy3eDAwbuoPEcD6C1HtUmcnPfiV1FX3
         T1TcYvNoRG35oxAcQoW/TyAkxXShO4EC744rRowxg+8GKXBtOYdHf/UOqUM0k9Kujw+/
         tbzPz88Y0yw5RtVZMlJvfqxVZ13UbZlB+nZQv2TuvDUhrITLOsH+vhRGAZe/fTSmW99S
         VLyw==
X-Forwarded-Encrypted: i=1; AL+hErGFHWzS6UTYFmN4lIS/FNKGm5Kpy+zzFpj4I/FxuKjxquW2WM2Ep7NM8+26Eid50ZeT0nlXofc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SdA7PrrfCDjCII5q1DpjLlFk5YMwjy2pCuJGmdGrlcQHery33
	yvI1W5dKK1knUonPWDFc2BLtwEuSdqpxkSvLbfX8Fakj/zkzJ+JakPKJuAKJAAmjves=
X-Gm-Gg: AYBFou1M/tZHNlKwId2K6Evmwl+3SPag7Ufr8eLvO2uKd+/9VxibnRpLbIo5yWp7czm
	OSgrD1JT1yUcgSc5h6ayo1fvwhSVjSFCpF4B2vm8cQOnoJ/dRp4VVZfDQeEFn6ACsq5TZb1Ol50
	Cn7QF1rjeFTBggojcOdHfNUMNjgW66WojKZHuuWGba19PXZnCNBG8eWCaog0VRTai/OWknI98pc
	eMP01n5BpC+kKJbmFZboyYdJkGEzg/CM/jtopzB1mYYAX5F3vGRZZ7G7mYuGg0pr+uXSLNOWXPI
	DdKtDlBoC3bgL8MwpU3XcGYQohyxbhvD0Gld8mYAvd3zISG3hwYNTyD9aU40WNhfJcOuzvt8wAN
	61sTmErWR/h+Z5TB3CSYw+yneaZegkKwx89I42VMNXJY6K5BXl2jj+vC3/92PrpBkbTAd4bmp07
	Ue/sSvl/SGl4k6aCHS0JoG/c06bs3FZc7cxzHXoyEbmPHHY5/oEruq+IoFxDbG1OqAGPupSyZJl
	SxEzNSJdJfgg3pV2iTGvvYZ2d2eQ61VFCLHJxao//f9gF1zkFJhZhfXh/cqw8kFsWyiKEKk0zho
	8+wnRbqBFM7/nVSUXiOCG8t/imMUtTpbzacMgHKo3WwGBWd9gqhjsNRGqVd+XDD5p7L/99+2q0V
	tAKqK7UMiH67dq3RNAvjV0vBiUIQlxg==
X-Received: by 2002:a05:6000:993:b0:48e:7508:bc20 with SMTP id ffacd0b85a97d-499c38bb64cmr5066357f8f.2.1794413923390;
        Wed, 11 Nov 2026 08:18:43 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:42 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/9] libceph: fix osdmap use-after-free in ceph_wait_for_latest_osdmap()
Date: Wed, 11 Nov 2026 17:18:29 +0100
Message-ID: <20261111161830.1336485-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

ceph_wait_for_latest_osdmap() reads osdc->osdmap->epoch without
holding osdc->lock, but ceph_osdc_handle_map() replaces the osdmap and
frees the old one under that lock (held for writing).  The function
waits for the monitor's reply first, so an osdmap update arriving in
the meantime is likely, and the epoch can then be read from freed
memory.

Read the epoch while holding osdc->lock for reading.

Fixes: bb229bbb3bf6 ("libceph: wait for latest osdmap in ceph_monc_blacklist_add()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 net/ceph/ceph_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67e88f30409d..39a0ddde3554 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -863,13 +863,19 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *client,
 				unsigned long timeout)
 {
 	u64 newest_epoch;
+	u32 epoch;
 	int ret;
 
 	ret = ceph_monc_get_version(&client->monc, "osdmap", &newest_epoch);
 	if (ret)
 		return ret;
 
-	if (client->osdc.osdmap->epoch >= newest_epoch)
+	/* ceph_osdc_handle_map() replaces and frees the osdmap */
+	down_read(&client->osdc.lock);
+	epoch = client->osdc.osdmap->epoch;
+	up_read(&client->osdc.lock);
+
+	if (epoch >= newest_epoch)
 		return 0;
 
 	ceph_osdc_maybe_request_map(&client->osdc);
-- 
2.53.0

