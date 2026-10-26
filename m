Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050648;
	b=RaV7Ansq0c54lYSIMLBENNkR5Y/L9fPHA+xz6OKTnq0Jecehpmqe4GhyclFiYOXiP0SQ
	 9C1U4Ih+Zpsdbp1phxCoVLbeSjo9STQ1zDSGu+q+V/SeU9bGOC4fhr0J35n5ZWntFl55S
	 XGwKFCEvMoxmX7y87puFCa//d8szP2sCZnErC4Mloe5T5hKW0hMSMqMEcs7jlm4FsJwdI
	 LFIm1SwfB00+q+umdc+tcylTx3HqfNrBVO87xPXw4wJ3Msow0h2ci0ltR4/7BF+Edpqe3
	 sFUA0N657cYmNa4c5Yj6UYGTmjIqsrAH5nDR4/WuKeko8+1pStJieV4HK7yVulRgtpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050648;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:X-DetectorID-Processed:Content-Type;
	bh=meiv+5dNu71BxUFRdWrQx3P3KGQyrk/OeZvnUffuhqM=;
	b=mOksoP8hCnRqUetvZjSVxZXN7EqEaF8KhC9PWajM/2JWYEuX624TbKAl4665y1gkBwGw
	 cprTP4WwM2TDWGW1tO50J6DV4A8dhfjIwER9gYLHl6xvcIJf4MxBF7YcfSoJciiYbHpgJ
	 9+Gs/yITMenF5jvYnQZwYKu0TH73ibMapoWVOg4+S1nUZm9GzeLIVhuUTJ/nmYYtLWQ4i
	 5Ui/TTTqSTfU3ei5y4B+BsgJnGGo6XBearxolj2Z8gN9s/hMopzxeMxkLTzH9wyulkVtT
	 8fLSnM6YqIOyEd/6oYJZ37K8sf3YkG5ON7Sisq++CVJCbFg3InQ6P+sObvEVAI3coRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fE6Kn1FQ;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC0606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1DC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fE6Kn1FQ
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so220494a91.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793050647; x=1793655447;
        h=content-type:mime-version:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meiv+5dNu71BxUFRdWrQx3P3KGQyrk/OeZvnUffuhqM=;
        b=lj4eRLniCNk8R1++ay9ypi7AWChneAgGlxJ3rn1e01iJzAxD8qxjc0qxA0fAK/drje
         yOuNfM2O6A40fuozQart9nQIxQ8tAwJvXoRTSfe57dqLOSX/QVCEv+RnZy1J001ioRlP
         wh4VkJFQ06OCp0DpeSO2QA1chbL+N3LoZc9VDa/QhNenEuDCViKiSXfkiESXQfXFLdT7
         C+5h1GgwnbiVPt0t00G5xJ6XJ24suqGr5zEFthQctbxJjZypEgnQtt/eYL6nYS+i41Xz
         Skr/ycmg/EhwcKZfjsPCkK6XQM1Vei38qluwDnWlDgZOC2S/OPyPY695XozDlUv1db09
         KppQ==
X-Forwarded-Encrypted: i=1; AKwUvBwOQ3rA7ze9IgBIcM1JKAOrCJJofySBVcP3V9JEKtZ6oS15OuQNZpWpw1jmod7mTbGHles9jBM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3MvxR+BjFuBaNKYeSVFWib/eSNlJxrnpw1gpjEIyuE4Ck/gaI
	JYAc9bLiSkYwZlrCpmw5t85yi9gehK2uWE2XUETGpe+tfgqIBq6xgzcNesVaQplyfBy2SUcJ5iu
	1DQLF5Bz42MCRmDUZQKOaJ4rck/4/ZWtZ3bMY0GZcR26pjAi82hdjtR0eVTyjAcb6W1uosbY8u8
	6dzoVUvpT2zCY+Tmr2cDdE0MBXASHDtNIyfRbisLsitDsoxjj/I3tjoHs2Esdb3vUv8f2s6Pca3
	A0LNokD
X-Gm-Gg: AYBFou38YndPMamPqflWZz/4ZnTL8VnWzwEl70bUlSHm3G2CWsjpCjCiwvzaYpkuYp6
	8LT7hZ2b7NzIqiXA6rU3oh2CcJCo5NvSon/KJe/6uddXz7h3xBUWHihsIeL+twcp27uGeaCv1yg
	fyWdYyOpA/S3Pz5WTbTz3Y2sRXt56uAw/oihLFL+CmnCBHXus6Twby78gmrS3a2UONRGE6P4mOE
	eHPLFc7/TC7pOsuTrdizB9n7ccWdTOBPftmg3xcGDqXClo1nn/h1iySzn9NFxf6vq1ulIRMflV9
	4Kd1XV3j2daK0jZCcm8oU1dlb7kn4b1MNI3mqD0+DoeRcPz5iMYj12y8zy1L6/bh/BY+HXScx3Y
	rIMQS0/Nm+1i/TZaFMlFZqP44auZ3WLr+k1ol4/nLaN5dkLvOko7+7/HwJ5NWT4P7GCRYWv1nB8
	YPcFt4eyot28MS9LTzRly20W0eWg+EziUi
X-Received: by 2002:a17:90b:1b0a:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3ae403c64fcmr347929a91.38.1793050647205;
        Mon, 26 Oct 2026 14:37:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adeba44b2fsm3158672a91.1.2026.10.26.14.37.26
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:37:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a2b6fab7a6so404295c88.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793050645; x=1793655445; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meiv+5dNu71BxUFRdWrQx3P3KGQyrk/OeZvnUffuhqM=;
        b=fE6Kn1FQgSZcNe6nlWSEb2CN2Cxm7nQhhuij4LUfFQfIMh9zfEgB5W+frles5PF1Eg
         3vfEwrlX3ZehM2B3xzEszH52+GsJnwAlDWzOH/X5y8JSoCjkzYmu/YUZDFXXog2aXnx6
         +EVdc+TKZDjNwoGs1WHRvQ5vVhWBEpShGqNkM=
X-Forwarded-Encrypted: i=1; AKwUvBz8ugjX8cSv/q2VA3LeD74NLSTvtxRWr0GGCnW3SPP35x8lBD5GTaDUTFxoZfpaCy/aXn0HHx4=@vger.kernel.org
X-Received: by 2002:a05:701b:418a:10b0:1a0:d131:662b with SMTP id a92af1059eb24-1a3c7666e26mr1044933c88.6.1793050645080;
        Mon, 26 Oct 2026 14:37:25 -0700 (PDT)
X-Received: by 2002:a05:701b:418a:10b0:1a0:d131:662b with SMTP id a92af1059eb24-1a3c7666e26mr1044899c88.6.1793050644459;
        Mon, 26 Oct 2026 14:37:24 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a21bc6cbsm26705289c88.16.2026.10.26.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:37:23 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com,
	maaz.mombasawala@broadcom.com,
	Zack Rusin <zack.rusin@broadcom.com>,
	stable@vger.kernel.org,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: [PATCH] drm/vmwgfx: validate backup buffer size in command buffer processing
Date: Mon, 26 Oct 2026 17:37:12 -0400
Message-ID: <20261026213712.244907-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000caae0c065ec522f6"

--000000000000caae0c065ec522f6
Content-Transfer-Encoding: 8bit

vmw_cmd_res_switch_backup lets userspace bind an arbitrary MOB to a
resource without checking that the MOB is large enough for the resource's
guest_memory_size. The dirty-tracking bitmap is allocated based on the
MOB size, but later accessed using the (larger) surface size, causing an
out-of-bounds write in the bitmap that corrupts adjacent slab memory.

Add a check that backup_offset + res->guest_memory_size does not exceed
the buffer size before allowing the backup switch.

Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")
Cc: stable@vger.kernel.org
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-34068
Closes: https://lore.kernel.org/all/BYAPR01MB38301CFC012E873340F77E3D80662@BYAPR01MB3830.prod.exchangelabs.com/
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..0156aee84c9f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1718,6 +1718,7 @@ static int vmw_cmd_res_switch_backup(struct vmw_private *dev_priv,
 {
 	struct vmw_bo *vbo;
 	void *info;
+	u64 end;
 	int ret;
 
 	info = vmw_execbuf_info_from_res(sw_context, res);
@@ -1728,6 +1729,13 @@ static int vmw_cmd_res_switch_backup(struct vmw_private *dev_priv,
 	if (ret)
 		return ret;
 
+	if (check_add_overflow((u64)backup_offset,
+			       (u64)res->guest_memory_size, &end) ||
+	    end > vbo->tbo.base.size) {
+		VMW_DEBUG_USER("Backup buffer too small for resource.\n");
+		return -EINVAL;
+	}
+
 	vmw_validation_res_switch_backup(sw_context->ctx, info, vbo,
 					 backup_offset);
 	return 0;
-- 
2.53.0


--000000000000caae0c065ec522f6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINGz
zgaeHDUD1qR6RfMe39MZanfKnPmUL4Nfj8NUrPaiMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyNjIxMzcyNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAB3wDEP4kNfV0GPGBnOHwgoCoD6+wVKShldwDssJ
Tv0RNC+nVP/iETXa/i9LyCJ62NCiEJmfF4TnUxbtKAfmetSMXLtMp2X8YsSI+a89Buz6f1w+LoV8
Wnztm7LWveFUpQHx+/LfmHP61mvobq9SlO+cK3fQm3HoxBNLGH5ovUX5ql8yFkdZpeo5vCv3AQuW
vVciHpQ9+DuJAN0QjzNPB2M4rbwDQEiCONFyM/OyosurXbjtIGSnTzJByFRIpK3b/gMpEHZYv+7s
En5Jbu0CaYqGEpmPU51bz4CIfRT4pTgEFLdsh+HisDdPdophdXITSbdiUS8MnVAihYmUzRlmSQg=
--000000000000caae0c065ec522f6--
