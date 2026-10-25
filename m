Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792919261;
	b=OQePfmshQG9rNF5ZPookL3Dp5dcw/l/2yp0PPLLCrvflUIjXacf0qNju4mbjLSY2PIFX
	 4NUBjc8Kz/8c1jmbS2sz+5DlwYKrUnf5pwcs7zTao/NVB3E0tcKmPnMIA4hDSH8aN1OKt
	 9bMyk9tJvSdHPYPVgHoPn7AGNwTVE+71lqHOcSw4qCH/7cdYMYT4qFJOopQUZ4ihCBeIF
	 4Cm+aTVZlhcGMo3rng5A/pk1bNYOJRSeNz2s170YygxHja+FxfqwXobgDgCDxPXAr3eIv
	 mn/zxfel7sed/TPnLdBgXfEs2/pCDII+nkOO0fVS9bDJy64YKo+GNGysb+UgVAxKbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792919261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/dIYdqOLAkHeO2RCiPKPFUB8jMZrrEYZH4Bk6Bmq0Tw=;
	b=fNCQxh3u/IAQHv79uWVSoJcYwI28kJYUKPv2hemAYK0myOrVpRbN7SBOEFpSUvBmlchF
	 N9U9EgKlacl5YrRZjoxRs5oFsgfNparEbe4LIBwqTj9w3TU6gGWT7N2SR7+5GSzydbNyo
	 db6ZHIwSpbBVynhAfrWaboH4Gh/C504hxwcKh9BRgcCXnii99YpAgMB3QChKXb27bSi3t
	 yX9i2TmHhDmCKRiVpwFhz131QL9NlGf3JivT1dil6m8VHCq4P7xTWJ4CW9QFIBvF6D51A
	 9RBKlC/ogz3VBrI6CvyieRam1/Mqhe0pAk8gugrC2fbHk+n1+a2PbjStNSi1wFcz3Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=reU3kH8T;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60231606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 09:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60231606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=reU3kH8T
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35f1f76ea84so3603659eec.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792919260; x=1793524060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/dIYdqOLAkHeO2RCiPKPFUB8jMZrrEYZH4Bk6Bmq0Tw=;
        b=reU3kH8Tibh8CvDEuQthjv2+W4rRV+cLOaFvn/VF1gieSmyp4esJxPUvsZhnBEpvhh
         ho/5xM8taJpiW+v7hs8vAt72EMkx/Kv/zFicXEqFAYKNUaPCUrc4mKRUOOlIzq3O8edu
         /8Jpr4WbPIbbKw0RDSGgq5TDjk/R0ExscsiaXmbg6NKw8uE8zxqig8dIXU5lMNYk6raf
         25dz+yC4eEJ6U5TyCG2wlrJGrf4Rd26erPHdGWxOT+AZMTijYMUzIx67NMgIPUqLniNG
         gUDUfnRMnPRqRhmYdEQn4vXYk06hpclzEBdbpxWbyaXirXOBHyD3VZX+zBaDjX4MkVaK
         FQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792919260; x=1793524060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/dIYdqOLAkHeO2RCiPKPFUB8jMZrrEYZH4Bk6Bmq0Tw=;
        b=Wt3hOsxcMbEs9oWuV6YizJsjsNRzRclm9InGQFNtpRTKbZ5HuWVrkMzytB1afrAVq/
         WRRkCway9mVnEK7+PSdx5jjtkl8hOoDHvBaEd/oFo07NM1eGQvA4OHz4CMHpbB2EL09t
         srb1StY2BHnibu5L0gQP1en9/UG3GFFidvRDhwuZQ1JJ8dS7gByLqfxrtSbKl38PiGN0
         C5ZKHi+gQit23FpUBq/YzVNkapMpRKIJgHzgZuj958dxgRg0JpZIC8MMfw/HGRvjLbzn
         kWIYwkK35sU8uHZPZ3Im0nUzBXbH7qSoqKBkTkI6huTdHOKrLyXDddzGbUSKjVrtdjzc
         IOtw==
X-Forwarded-Encrypted: i=1; AKwUvBxMZq7v5EATFU+Je0LcAo0CPkcOVnQWVC3OkFe5H5lhjKg/dsG539I+3I3LKmAodPtWEG6VPuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyKkKxD3Oz9RkvSzijspiSlzK5ypHrz5Sbjm339tf6tTKu8viH
	IM+0u2/IQoGQnLdwnQf617kljzM2fddUPwhE66mfbraaGZtIIDRQ1t2P
X-Gm-Gg: AYBFou2eGLqi1XXHCp6bucLsUrnL9xhNe9NHEMqMTDJb3iRsXUAsf5jbLqcEUqRZt+J
	hEvpxbHm6yy4LMbK8h7uHmltvfU6WMsv6ibWItoEHVTIuV3MdQ9qPEOPXOFXwwMQ+ycnoT1QuOT
	IshQnibr2ZCL5ER4ihN9/WVbfoWuhUpuDoVr3IcML1IjdiO8DluRhxxfS6saH5iY7KCUpgxkkpF
	v2N+Hp/gKJS8/BOUC8gJvtw7E26/sI8WQhP4mKzrxMViug/OhAOEuc6yOcyZIxjCxVvgdQolpkB
	siN1x6IL1AYGHOFdh4E1zW10gPtVs5WPVFlPhVRtKZnjn87ihIxZblfuMYsS+Vn+06/wdl8IdIn
	z826fADVi0eXn11rOTf64XNw/ag1nUH7YYn6Yq+3YHvMJ1/fGbQyxB8hjmrIsa245FuLg05Mpdg
	cRciKpqMixIUQWeZFKYAcwnNM07QS4Hisz+WxVWl/rzYoWvHuU7I2tDRo/TnDuk6XWtVZ7Pd/lc
	6jgs5IFvSbd3FmV7lAsRCp/+5TAgC23u4EICSjukn4pbcjVj35oPYRTq+L3HGbrj+1ySVwAQgHI
	AK2pUUnqE7bC/MIeNsRt7bMzp1+U
X-Received: by 2002:a05:693c:69d0:b0:369:f9b6:f471 with SMTP id 5a478bee46e88-369f9b70b8emr1360895eec.24.1792919260380;
        Sun, 25 Oct 2026 02:07:40 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec4d73sm19815122eec.22.2026.10.25.02.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 02:07:39 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	David Howells <dhowells@redhat.com>,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org,
	co+24c7c12d69e63c6d@bugs.sh
Subject: [PATCH] smb: client: stop processing a read response after a receive error
Date: Sun, 25 Oct 2026 02:07:30 -0700
Message-ID: <20261025090730.2893106-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

cifs_read_iter_from_socket() may call cifs_reconnect() before returning an
error.  The reconnect path aborts pending mids and invokes their callbacks.
The callback can then release the cifs_io_subrequest containing rdata.

cifs_readv_receive() nevertheless continues after a negative return and may
dereference rdata in cifs_readv_discard().  KASAN reports the resulting
UAF:

  BUG: KASAN: slab-use-after-free in cifs_readv_receive
  Read of size 4 by task cifsd
  cifs_readv_receive (fs/smb/client/transport.c:1284)
  cifs_demultiplex_thread (fs/smb/client/connect.c:1355)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)

  Freed by task 148:
  netfs_put_subrequest (fs/netfs/objects.c:267)
  netfs_read_collection (fs/netfs/read_collect.c:460)
  netfs_wait_for_in_progress (fs/netfs/misc.c:462)

Return the socket error immediately, as this path did before the iterator
conversion.  This also avoids adding a negative length to total_read.

Cc: stable@vger.kernel.org
Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Reported-by: <co+24c7c12d69e63c6d@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 fs/smb/client/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index e266859818a441..b7c0ec5d956551 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1272,6 +1272,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 #endif
 		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
 						    data_len);
+	if (length < 0)
+		return length;
 	if (length > 0)
 		rdata->got_bytes += length;
 	server->total_read += length;
-- 
2.56.0

