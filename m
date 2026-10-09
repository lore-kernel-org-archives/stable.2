Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213F476CEA
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532990; cv=none; b=hrFclARWjiqe3yTlwlKvF+CqvxWhgla44TVRv19q9D2shSDw4b6OlmY+cv/NwmnZ7WNRPbje9K8mMfoYt73RjWkQR4JUii9P/xKhF3zsUXphurLaOJWJ2NLc/J+YH4JA1b8LETVaQbG7zo6f83KjKLrRpDLCvnfJAfL3kz9zTjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532990; c=relaxed/simple;
	bh=PNIWbf1MaE9ijfXHPhmWrJ+aqZsWffS2Dcf0qEM2kxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwsilHdMiG9IDAcP+d1KGo3o7U5svRrt57kqlnB2qszLe+LtGnaw3zUg3cSluKg3I9zYl3JpdT7kynaAgGnhWwvb/pBNl9+K2U1qY2zAshSHYfObyZI/Jg9Um+s8slawp9D037tzNy9GndlazRcYAQTg2xn1gDMzQ3A9jBU2Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6a09IS7; arc=none smtp.client-ip=74.125.231.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6a09IS7"
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824f3901d55so2216473a34.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 01:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791532983; x=1792137783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=abrjBZtqWK4ithY2rB/XsxNJwm1DdDO75e5ZEpU8VL4=;
        b=j6a09IS7hRbMC4+xv+vZkh4RTWexSe62b1qUFs/0A0aiDSlyo3BOckmG6b1rDruCN9
         2hoBArsVve4vTsWRwqxo4cgSXnbIZSUGzbYkOuLS8KUinGmIeyDyCh0nj5kE6Wrn0ePH
         6tqc7Ku6lYw32sNyd0wrlcbSo0HaUT61e3DThbvc5pV8EkDBSts9eu3ooH/D89JZIUOz
         AJmls8mcKJuSm2ge/YBvJp4kr21IU8H3zUimLKMOhQJAXRMuvBEXgH/1PtwuHKpKHFDd
         igIQeK+W+YCSY7q3k/vxYsN4mslcp00QmpYTBek9iBJxPLkyF4DEq9CospV0BXDW3+rr
         qQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791532983; x=1792137783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abrjBZtqWK4ithY2rB/XsxNJwm1DdDO75e5ZEpU8VL4=;
        b=XbUmjIBKNGTyJnm++anRooCIH+Gp1+Hz6b/IaMDLIRm1gAYV5Pxbc403/9SLSo6N6+
         GLNxr35At+Iny4hHE2HIuBxy7YAFRC9j0Xo8BTe4oOOAFVUTUsSrAj6caH1Ptv6jSP1O
         R9zQ3ZhU8+ONP9ivt74JKYWLvpGQ3qfXyya+bedheDKlX9eMaXkl41SHlYHExVCoBncx
         SuDMYKZm9cLq/zjp9z9G9M4x+bfIPO04f5QZ1tdYtMhNd5/zNn+f8WwNXvgGhg9X3KHG
         +e53YP5mvnvubxNNe7k8Ca/CuBvwlc41135uhQlYaTeEqUCkQdRR58Za738IoRsibnRS
         cPqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgF9/C2PbVgKFeI/1NTT4ndMCI/7pYLqrQ9GGjaQFAZ4UDlAZYT4YhuAXyngZdlygJz+YcsSw=@vger.kernel.org
X-Gm-Message-State: AFuF++mnHF2GTUSN+lU3o2m0jM+owiJLeHvD2o9dqvwJH/rGVlXmGGfJ
	IjEW0STUoAlVI1y+JOtuA/cL0ffTVzQqdK84B9+QC2AJrxVk12wQFnDi
X-Gm-Gg: AYBFou2Yv1SnEl+H/t1kuL6WX9lXLByd0tR9IAANyQqPZ0UBY3F/jXqxLHHCBNUO0vq
	AKuW94J732vqgWxTuaSreC5QRHqLKEWNii+RdSBsK/Z3Mi+KO1ilSEzD4dKucbPpYjPshtpCdK7
	U8AA7VA8s1aY9ATGYiKjax7j5R1fwBEdCo5+6OVTUGWQys5PpWy8IEbvFa/URILFzYMN6mdxNGJ
	zJxJtJZtFhmrALg0PU9VGeJfns9iNe58y1uP5EpvvnpBb+3jbUnqbWdQ4JHjq16EBUWNe3/194a
	LvrHXazvahTlEl8RgrkMGkUL/jeyoPitIA6kjO+/cqW8k4KBW/Xd6pk32NuncS84nOKhSO22Wm6
	LFCUu8lH0vzgK1CNjVrbkzipqmer86uRy5Hq209vxLFc+uG9hF9U/c35YgSPOe2D/IBR82V4Pz5
	d3gVX6DLyeuBukKsOA9CbE3qEMetmvgoQj8DaXQr8JXJeylLc7OASiUCmicjrxSRK0iZgfwYayR
	/T4Ff61huj0qu5sE2RqrdDl8Cu4zKtpeR8s
X-Received: by 2002:a05:6830:449f:b0:816:a9dc:6d05 with SMTP id 46e09a7af769-83090b2e4b5mr856599a34.4.1791532983102;
        Fri, 09 Oct 2026 01:03:03 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.166])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039d385dcsm1199706a34.21.2026.10.09.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:03:00 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cifs: fix use-after-free of server info on cifs_ses_add_channel error
Date: Fri,  9 Oct 2026 16:02:52 +0800
Message-ID: <20261009080252.2805877-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path of cifs_ses_add_channel() calls cifs_put_tcp_session()
before cifs_chan_clear_need_reconnect().  The latter reaches
cifs_ses_get_chan_index(), which dereferences server->terminate; if
the put was the final reference, TCP_Server_Info is already freed and
this is a use-after-free.  Same put-then-use pattern as the recently
fixed sibling in commit 717e0a25036b6.

Reorder: clear the reconnect bit and drop chan_count under chan_lock
first, release the server reference last.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: ee1d21794e55a ("cifs: handle when server stops supporting multichannel")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/smb/client/sess.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index e095f41b5882..650c0f855a29 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -626,12 +626,16 @@ cifs_ses_add_channel(struct cifs_ses *ses,

 out:
 	if (rc && chan->server) {
-		cifs_put_tcp_session(chan->server, 0);
-
 		spin_lock(&ses->chan_lock);

-		/* we rely on all bits beyond chan_count to be clear */
+		/* Clear the reconnect bitmask BEFORE dropping the server
+		 * reference: cifs_ses_get_chan_index() dereferences
+		 * server->terminate, and cifs_put_tcp_session() may be the
+		 * final put that frees chan->server (use-after-free).
+		 */
 		cifs_chan_clear_need_reconnect(ses, chan->server);
+
+		/* we rely on all bits beyond chan_count to be clear */
 		ses->chan_count--;
 		/*
 		 * chan_count should never reach 0 as at least the primary
@@ -639,6 +643,8 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 		 */
 		WARN_ON(ses->chan_count < 1);
 		spin_unlock(&ses->chan_lock);
+
+		cifs_put_tcp_session(chan->server, 0);
 	}

 	kfree(ctx->UNC);
--
2.43.7

