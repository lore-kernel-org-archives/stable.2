Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201263;
	b=35m3w9FCBoycCpsaFjHf6KbxD9LaXjcyM+imD8s5ACWWQdztd18CgvBI65g7jYY/Ah/T
	 FmwcsLYP7yBwyvvS/txwIm2ow+U8S/YZz0rpSmco70+nsMVBcYcuSXc5OFmVKRbInVG4G
	 jEIbN8c1MrtV7EoKSdUPHUV7RccuZD7+WPkBudc1ytw3XiTYQ+WNxDwJP72mlOLs4zAKf
	 IwxW7+WR19ubNg/iS2XU1X7IT60hhJSl1yDHGAXcw/aszH1sOevlJXf8JjIYM1xQ62Ub9
	 l2EAsUqk2NtvToRSPGXE4AKaOswkNDySDtZSfy0GpgfaED00SQpF4n6RmXHTz7i4nhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=x/cJrK5hJQJmQXtcIXag07pJ6jf6c/C/z5CdzDpNgrk=;
	b=uO0KFx4CpYmcegnlFq7LNdvTgQXyYjn3GktrNFY4oYSpnkWGj22HZZPxDvsArng5W0PB
	 12xbFdkSbDy90XyuS7fV6wyubbSjuOU5uuxwWibjor7XtzY++YhF3L9Gdr6tgsFIPVGCj
	 HWOZ3R0v7Mm5vuITfnMWwaP5cNb2XlTzgYchQ29P6yCSGvcKasuS9B3yO6xVDELa/+dN3
	 TvDRbgsVIW1M7f5c5yuH08bXeJqfMgWcPKM6wqRy7OKVzjYp2kOe4d1Xnm0ydWh5AsyKu
	 q8t2F+ROOYCWeEFm5QdzLdbh7YcpoVjp1Jtq5XNb70g8rQzBJzhcpSsOlVUzKosdvtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AmhXsJnY;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E040606A33B
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E040606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AmhXsJnY
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b29df78132so1275744c88.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795201261; x=1795806061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/cJrK5hJQJmQXtcIXag07pJ6jf6c/C/z5CdzDpNgrk=;
        b=AmhXsJnY8o3C56RbAlXbU+Bi0XX/gdu1MWR/y4VMv5sQCrOu3hNJnl5dqiBWXp6qP0
         MsuTOKUN7kYipxQ6RWlHsw7mtKXz1pg6LKef0PfQHJ4vNxBw7c3Etf6+I0ZqnN3Gg0mi
         qZuZ1jNqj+m+ZMSrUcSPjPHt273G1iVvHT8xJW4cYJSn76s2akkXu9uTLIzMyhq58G61
         HJL7isCTiXNyii/pX82R3AMby4hSQGuN0jpOTvkTq6Q4I0wZVHtg0QfmknIUXvPSYBZi
         v3D9MpadfuHQx+ISWDzy4YFb9fKMQA1xsIS05Z5xMp3I4Ksqo/spvBrG/L7Z6QKjK4FY
         yzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201261; x=1795806061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/cJrK5hJQJmQXtcIXag07pJ6jf6c/C/z5CdzDpNgrk=;
        b=YhsBPVKFh6Pl6DfyTDyQdU3f0q/4GTMmef+NGnJW3UtPXmxWfuqW27y5U3z/JQ4LYK
         KFhJ3NMSSHt79xgRGG5W0lThnU8kyfSmYUNb8OJoH6EbVWBfC5OAjPT4jvWYMfcXCLbJ
         BaQPtc92OodvhzjHAjjUPzFQqhNhvVPeTfMqM3aOqrVZ6+aA6rvHbxxYgTQ8jsRKfkic
         21uxOahuOCSLUsw9DkR17jSMUwussYKgqRe+1DcPOTi7614JieoM0pVQ1EGaxFUdkw5R
         TlcFwbSubbWEAFrkWJIebwcafNHwBlExoWlIh7JoUiGBNo/S/I1zjID3350hHN6OqqPA
         Vlug==
X-Forwarded-Encrypted: i=1; AL+hErEewwhHv8rQ2zIBOEbo+FW2MXaYY+DyGyfmtOybF5mPeL+LPLQ2QaQhKSs0pceixQbta9ohn38=@vger.kernel.org
X-Gm-Message-State: APuU4Z806DaBNlzH7Ru/4SORK+4MEBIrApOdWCXjjq1aWyo3VkTd8QDb
	qwqvYBn5pWPnfyF8mM3ZD/y9UzThW/7+8b1+sxg3OqfRF3bVwEg0tyC2VJ1bMtbuYNmogQwaJUh
	yMRYb0Oerjg==
X-Received: from dlbtu1.prod.google.com ([2002:a05:7022:3c01:b0:197:f679:f62d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e882:b0:1b5:481:ff0f
 with SMTP id a92af1059eb24-1b55692fd20mr3946544c88.32.1795201259386; Fri, 20
 Nov 2026 11:00:59 -0800 (PST)
Date: Fri, 20 Nov 2026 11:00:31 -0800
In-Reply-To: <20261120190031.1587531-1-irogers@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120190031.1587531-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120190031.1587531-4-irogers@google.com>
Subject: [PATCH v2 3/3] scsi: mpi3mr: Avoid ready_timeout underflow in mpi3mr_bring_ioc_ready()
From: Ian Rogers <irogers@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>
Cc: Laurence Oberman <loberman@redhat.com>, mpi3mr-linuxdrv.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 9634bb07083c ("scsi: mpi3mr: Enhance the Enable Controller retry
logic") caps cumulative enable retries at 'mrioc->ready_timeout - 60'
(510 seconds on firmware advertising a 570-second ready timeout) so a
retry is not started with less than 60 seconds remaining.

Because mrioc->ready_timeout is a u32 read from the controller's
ioc_information register, any value below 60 (for example 0 from a
broken or disconnected controller) wraps around in 32-bit unsigned
arithmetic (e.g. 0xffffffc4) before zero-extending to u64 for the
comparison with elapsed_time_sec, spuriously retrying instead of
aborting.

Rewrite the check as 'elapsed_time_sec + 60 < mrioc->ready_timeout' to
avoid unsigned underflow while preserving the 60-second margin when
ready_timeout >= 60. (Note that if any firmware legitimately advertises
ready_timeout < 60, no retries will be attempted.)

Found during code inspection alongside a Clang warning audit with AI
coding assistant help. Verified with a standalone C reproducer under
UBSan and by building drivers/scsi/mpi3mr/mpi3mr_fw.o with LLVM=1 W=1
(-Werror); not runtime-tested on MPI3 hardware.

Fixes: 9634bb07083c ("scsi: mpi3mr: Enhance the Enable Controller retry logic")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 1aeae8a55b1b..45544ad21a6e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -1734,7 +1734,7 @@ retry_bring_ioc_ready:
 
 out_failed:
 	elapsed_time_sec = jiffies_to_msecs(jiffies - start_time)/1000;
-	if ((retry < 2) && (elapsed_time_sec < (mrioc->ready_timeout - 60))) {
+	if (retry < 2 && elapsed_time_sec + 60 < mrioc->ready_timeout) {
 		retry++;
 
 		ioc_warn(mrioc, "retrying to bring IOC ready, retry_count:%d\n"
-- 
2.56.1.750.gf70dc682cf-goog

