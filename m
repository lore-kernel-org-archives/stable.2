Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514243;
	b=efdHjiyY34C09gY9a5NUllTLVd3njREDpn3eKOPi8HjnVM0RDDF+TZbgWB7Rw+5dGQiC
	 CL57fTIxHOSf4gpuVABI3EtR1iyYaMoe69Xnp8dWXX0RpeQE4CdCSvcsUtQHZCwu8WIM2
	 WtyxJP6NT1RBLkRS5iMWIYfSuVJk+TMFCj+A5zCoSyACbBJhBl+dyq4Kexs6hBwy1DH4M
	 jdvjnvPRC0a4jCI63kg+r+MTAjdfPA4OxrDOqHaarvvSSe6diKtBFl5XDG/qAa2KmJFe/
	 dbbelwdKSz9Ofb0pBtHr3amAJHgrqNph5j8Sd97Y/jmKjnpuqv2lRbMfq5ltA2HAhvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=U6RxQqnraCujnuFyGwdEGaWyvDwvEokaINvEdRIrFx8=;
	b=jbM3605PN4USBLlgw2vVX+lDwZIF81anfVkBWwh9qV51h6GytoKS0hKUegQ7WxJJ193N
	 eMgOISwXZ9w+0AH8oLF48ar+nlrjEo1lR8lN2sGSceG8mWf3VJ9Jiy9gA+IZynHsewTMi
	 TWiSIs7sycBx+din1N6Fy+xQ8YzJDcCf8UlFN2q8i04VPN33HmoN8btrGGijAoDd/R1EG
	 PqcMFGusc2s3GfYNMSXq8Oximzpypb23LdzjQeLx9vQS7A2oVouTStaxonLq+xs5yivwe
	 ylG0Vc4yPCHdhxwztA8HdLFKWBUmGx9566kyFxEWYT8MPd5Pmp7fFWSCDJuef7dh9xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g+y36DUi;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA23606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 06:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBA23606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g+y36DUi
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1233799a91.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 23:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793514242; x=1794119042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U6RxQqnraCujnuFyGwdEGaWyvDwvEokaINvEdRIrFx8=;
        b=g+y36DUiYCN2ds2/LESOdmzu3PGF7A+GvYMK9x/7YlArL7oT2RqzCbC7NN9x/SDBTS
         0oWBIi2bEnAH5Nah+GO8HYiV15KdoeWvW5QVplVNIjSksNN2uAJNsb3vKGBAPYHzn4Xj
         BHSLh+nlOiG/lv3XlLhUjtn2lxC9/FqCn5yE9kcQJxNnZSw9PDTApP2u4ezbgagbtHmq
         atRhM5RWODdjrTMb3hb2E6u34RoU+0wT9DBcm1vrFr9g1jD5mN/pUXFaY5ZETx9J7efm
         15nIY26eD7WlMkmHwyhpHBBV5YnyHcR3297OFdiFvMvfdEGQdRdWWKBnUC2yn90ENDOf
         /XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514242; x=1794119042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U6RxQqnraCujnuFyGwdEGaWyvDwvEokaINvEdRIrFx8=;
        b=ZjfjE0y5KVBJQJ+mJY2vAAQB4wfHoGSf43L8GURb+P8iE0IT65UjYkn9Ub27y5f0Xo
         1hXQSDuFZRUFTkeZr8UqbSR7mhq836AA/CbEel7REeWiOd9Dh3a+1KcVMKjBSkZ0jzXM
         5fx0oc+vS96YTelfc2Qnc+MI8AMlTZ4kX3ydYmtVYKVAPawXGQCXUOktc2HYz/hFpon2
         6A+DcGdU1uvsGj3MbqVVjBSPzDxCRmia4DxvxEhw4i851gRoWndi/byHDPIWmmFa1B8C
         8OPpE+A6UagVr8AS3QM9IGn+UuMR37aMzO3cWS2PK5qgJg6Jn9kiBAQrjVfyX7Zf9bUw
         pnxA==
X-Forwarded-Encrypted: i=1; AKwUvBzUL0c3gTjTHpHMDWZqVpDFkEhGUWjJXw4e0l53NHUCtrL4cIdlvBE42kCCgdAl6HO8BJ9ZxSE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sKauc2qm9FBFZfejQkf8bu8mp9I2JwINDovB5u7IscC27sxop
	cIVrouDkHC6X9AE4r1fG7nnpHtoydJeAtLeLOWEADbVhxK7s2D/c4SZy
X-Gm-Gg: AYBFou2nGbFXZPuvPYlEqMMAjXz8y+reZVv0FBnEc/YanKqMHWLCfm1lIz3fkKmLMCZ
	50mpUy8kn2BauD5R6Yzvgg6GNt04WyjnhWcsujpR52TaGDnGJWg0LhCmxxwBQ6bw0/B65WF8MtD
	5UgoqMbsTRg5g+VN38Cb2k2TgwQ9lAkDpBXBBv369aB6iKjTwMQ2/OheW260XCEPwfBIkmwAIHp
	Qns03wzZoNbgMUoPw6NhMpY32xH/1Fgmb9OtbNIZZJDHTFquni65jyVpQH8Y4ynuokbg8sdqUN9
	YrY2ToeTt2SGrljxlHzylsGoWrGTk5KHdG3SxtMdO44B8Pj4ZVPkJAvocnM7BxxevEaPNjKKXrB
	O9wMXwr9N5woQiNj9W7vfRdTCctINniHhKGxfq7/i6W5goDK+LB2qS3zrRt38stx5fWEWTwFR47
	Cymuy3oZzYHc/DCgS/NiAaHN1a4toeqmv+++Z6+YDKISgbxScV+TfO+5U5GtokNO7+ZmJIwhKWM
	scCMkuvewkoFCKUGIVuv7oUe/truAR3sgLWS3HBOJHokO1XeyNVnc7Wy8EA6sIFKx9JNl6vhk+A
	ainjwc9q3bNi5+ZX/+1RTpKwwq/Aa3inSkzOYGgp0IAacw3jMJiIleydXVtq++UstwTU8nMNIUL
	P34kOJ9S5qCrBDLko1n53ei/MpX8nlckhtxMAuZdt/fQFOtMChADdhYIAjA6Ao2+t/MmkgeFpC5
	uqUL1YLn/omuwMWVfAySs=
X-Received: by 2002:a17:90b:2803:b0:3ac:96a3:77d5 with SMTP id 98e67ed59e1d1-3ae897e066bmr4668404a91.36.1793514242027;
        Sat, 31 Oct 2026 23:24:02 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm14092486a91.0.2026.10.31.23.23.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:24:01 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] stm class: clear output->pdrv_private when the output is freed
Date: Sun,  1 Nov 2026 16:23:43 +1000
Message-ID: <20261101062343.16629-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

sys_t_output_close() frees output->pdrv_private but leaves the pointer
in place, and stm_output_free() only calls the output_close() of the
protocol driver that is bound when the output is freed. The protocol
driver of an stm device can be changed while an output is unassigned,
by removing the policy and creating one for another protocol, so the
stale pointer survives a re-assignment under a driver that has no
output_open() and is dereferenced again once the sys-t driver is bound
back:

  P=/sys/kernel/config/stp-policy
  L=/sys/class/stm_source/heartbeat.0/stm_source_link
  mkdir $P/dummy_stm.0:p_sys-t.a $P/dummy_stm.0:p_sys-t.a/heartbeat.0
  echo dummy_stm.0 > $L   # sys_t_output_open() allocates pdrv_private
  echo none > $L          # unlink: sys_t_output_close() frees it
  rmdir $P/dummy_stm.0:p_sys-t.a/heartbeat.0 $P/dummy_stm.0:p_sys-t.a
  mkdir $P/dummy_stm.0:p_basic.b $P/dummy_stm.0:p_basic.b/heartbeat.0
  echo dummy_stm.0 > $L   # no output_open(), pdrv_private is kept
  rmdir $P/dummy_stm.0:p_basic.b/heartbeat.0 $P/dummy_stm.0:p_basic.b
  mkdir $P/dummy_stm.0:p_sys-t.c

The next heartbeat then runs sys_t_write() on the freed sys_t_output,
and unlinking the source frees it a second time.

Clear the pointer when the output is freed, so that a stale private
pointer can neither be used nor freed again. If no protocol driver is
bound at that point the private data is leaked instead, as before.

Fixes: c7fd62bc69d0 ("stm class: Introduce framing protocol drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/hwtracing/stm/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 64a9eb1..5b7dfa3 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -345,6 +345,7 @@ static void stm_output_free(struct stm_device *stm, struct stm_output *output)
 		stm_output_disclaim(stm, output);
 	if (stm->pdrv && stm->pdrv->output_close)
 		stm->pdrv->output_close(output);
+	output->pdrv_private = NULL;
 	spin_unlock(&output->lock);
 	spin_unlock(&stm->mc_lock);
 }
-- 
2.43.0

