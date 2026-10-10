Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270CA34A79D
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617756; cv=none; b=OCGQTB50J0/cEUwAINswl1T5K8WZGhE4vEaGGyxV/Q6BGRnyV+a/c9LUdFcYp8A1YC/aax6ior91HvHdfgTYVdQtVG8Aj4nCSYxE8lsFDPg/eZfxQwqn4S7rs1NwJPPdl+wWA6bJCCOkn79hGIfMX04Ys8aRg2D3ETLWVRFz/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617756; c=relaxed/simple;
	bh=TVIiJVHskzSYIEzDey9M0ArbAY2a1BkeAfEePyu89P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aJ9ZZHejAVs9ol+vEn5BpmIVlYH2mccFf6n0PbXTpxL4hDfQ1S18GWgwtkoTcPvAFzjaWSSg8QVhcmsclM+GlihRNQD25UJ+ltdDXm16osSE7BZPwm5czs0yhwutzV1iSluyvg0Nwfdl4IErSu0rVCSjAyOc5Z7hoLyeXVGhYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW8/KhOV; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW8/KhOV"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-44cdbcd53b8so191922fac.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791617754; x=1792222554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mpcc7xlu2/Y07yx6InZaddKVM8WwydxkM9aORRslbW0=;
        b=XW8/KhOVwpRa2CNtHq/mwytnsopj6hQe6A/T0RqZ30BWFjzgAhTTUm82k8EJR0Yqfq
         v4NuyJQkS54UY9Sdvtwvta4LYEHFhzf62tiywClCEwk70X1pH1XsnOj5Onc2C0pmLEKC
         w3DVLk/JCFht7NG9W744/mhHMWBMY+NKXh/ZKMYqlgv4V0xNy+vokqPrGrNAOVsNCvj7
         lgCZodGGjM/YCM39gz2OOXzuBicO/qMXBXqNVDzIZDwoZEG1jxH/1axIQj0+wIUww9tc
         pvcRMKR9Q3YGeAhh7MAQbestpZjxZe8KWbzSTGAXms1rj9L3NxpoM59BC+3ydz3CO8c7
         8Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791617754; x=1792222554;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mpcc7xlu2/Y07yx6InZaddKVM8WwydxkM9aORRslbW0=;
        b=RA40zcVJh67LhMxdn2eFnSpAPeZTilKxaMx/rwop+cFDu/FcNW8B5fEBBJJbdUXPR+
         +gsbwBcLgYHiEK07xUWutoMzfMqkh+0B+xB694lbwH9vUiBPYUOgAQTPeshF+QuRuM/R
         RNFfwyfJoAp6K01weI0LRejDhGwbGm0aTIEVZZfGY5krntXf3yRBT2VkY5U217XkDl35
         4wuWJQgDr6kFwodZTSAL7E+rHwPGnD7kf2DXth8jpfnUMjPOM+PVhR3oNxTaly52mU4o
         VwlylAfGbJjkAC6+qINuBxrlNyNDsNO0rrQ/Gb571sJe5iDNKY30iQ7SXRKnjMG3XaBV
         NqoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOdxxApmWCr45rJXvGNOqCu3iJou2vyqfmitXS5d5QifeXKbi5A6RBBDedqC3oYyvjn5fUhXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZ5JgD6My90uiqMjFmxQlDD0UVLq6+Pys4da6RbKcawX4d6Yx4
	n6yWwcRFPQfMNv0ScfrIBTqvUSwJE0QoZvP+ClJ3Fi6Xb25GUEkrcNdkPMKcXAlBvf0=
X-Gm-Gg: AYBFou203udKy0ICFssyt/4sPVxmADVG5e/Iqob1KXdgCiuHQv68iEytzD7VYaLbGub
	S9IAS4UZmn455PQTAguvoFhSjIxRZMruiLsPsp0Bso4ZXkzQR7aLbqXU3sGn/kXqT4Ul97vTO+9
	4dB1Muratvh8v755Jr07fSva60vslrfHnD1lgMYJ+cxknTHEWAgOUOEM2ljh+hZtm5wn0HX9JfV
	iYfdEnvcr5qerIwMQnnL1cjpUWSLvyLtbpLThr9MHvkD7F3XJZPQUEUAVOxxQIQ/yPgYCnkmUKV
	aHUcw0FYixWaP6rLoRop2iMXP9/04ad/JzNFo3EzH60EFFUoEF27mbjqipowXIWHRt92c39KFzz
	ZLh8nVBlI/NyhsLIE/3RgpzZxLb4jhprYQRNMzvcXuUX/X9a76he0I2tZoRHNMspBpmz2RkR9LE
	0nrgMPgxR/z66WTyBLHZoDuOAY1VuAZbCKSSpDxLc3ktlO9PDKH04HHikltt0FIsWwJ70hAb/UM
	sTXPFX06oEk9vU7n8aeAEc2vvL2uIzVMMCK2Q==
X-Received: by 2002:a05:6808:4f6c:b0:4c2:5ac:7f9e with SMTP id 5614622812f47-50c54177a49mr3775147b6e.43.1791617753910;
        Sat, 10 Oct 2026 00:35:53 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c16755587sm4618243b6e.5.2026.10.10.00.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 00:35:52 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] libceph: fix client panic on MDS message with data but no data items
Date: Sat, 10 Oct 2026 15:35:41 +0800
Message-ID: <20261010073543.2912416-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mds_alloc_msg() allocates MDS->client messages with zero data items,
and nothing validates the on-wire data length against that: messenger
v1 calls prepare_message_data() whenever data_len is non-zero, and
messenger v2 unconditionally calls ceph_msg_data_cursor_init() from
prepare_read_data().  Both reach ceph_msg_data_cursor_init(), which
does BUG_ON(!msg->num_data_items) — a malicious or compromised MDS
can remotely panic any connected client (kernel denial of service) by
setting a non-zero data_len on any message type that carries no data
payload.

No legitimate MDS->client message carries data items (OSD messages
with data_len > 0 always attach items; MON/MDS control messages
carry none), so rejecting the combination is a pure protocol
violation check.  Turn the latent BUG_ON into a connection error
(-EPROTO, error_msg set) on both protocol versions.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 0d9c1ab3be4c ("libceph: preallocate message data items")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/ceph/messenger_v1.c | 7 ++++++-
 net/ceph/messenger_v2.c | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index c9e002d963190..d0978c9031a16 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -1226,8 +1226,13 @@ static int read_partial_message(struct ceph_connection *con)
 
 		/* prepare for data payload, if any */
 
-		if (data_len)
+		if (data_len) {
+			if (!con->in_msg->num_data_items) {
+				con->error_msg = "message carries data but msg has no data items";
+				return -EPROTO;
+			}
 			prepare_message_data(con->in_msg, data_len);
+		}
 	}
 
 	/* front */
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index b323b61e70239..9ad43214bf984 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -1834,6 +1834,10 @@ static int prepare_read_data(struct ceph_connection *con)
 	struct bio_vec bv;
 
 	con->in_data_crc = -1;
+	if (!con->in_msg->num_data_items) {
+		con->error_msg = "frame carries data but msg has no data items";
+		return -EPROTO;
+	}
 	ceph_msg_data_cursor_init(&con->v2.in_cursor, con->in_msg,
 				  data_len(con->in_msg));
 
-- 
2.43.7

