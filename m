Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90833B38AD
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113644; cv=none; b=G2mmufeQdFMOu4bgkPE0QHIhc+4jZF4a1/WSLKimK4KiauyZKAFYVLffj/AkK8Pzfat0ZQpywiK/1cgy92TwdMIfEP4XgMc5Ay1AMfM8HbtokfAQMgTkLB8rssnEXx2JsW8V1qLiJIxNKtE/vCXytGOg+cDVBQ8fTHaHQXyWq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113644; c=relaxed/simple;
	bh=kTpWap4f0tmKu5jxywAQC5fOl8GUMZlIbJrYXMIdpcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HU82KAKrcVta5BEb3jZv89F1etzuxB1oOVvWhNKwt5Y5K9VNzie+nAN9As1zKx9rt8PlyKLAlzNoW2uB9zeU/2yPJifteaQpQ/JIFPenr1ySRjDoBV4pN5nD/6B37hW1ut3Abzx/nxhKnSYuTx8fT1shIczv6cuo3nKBsd7wqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLmqKQgM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLmqKQgM"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3430091a91.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113628; x=1786718428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQFVxxu807wdaX5Bwa/NPTU2e5DLee4RPhU/5SIwcTA=;
        b=HLmqKQgM+6B1/TSaLEFoDk1epmccWR6ofFU44i96WA/IGi+YsWWF/PyOPjGDT9OuOg
         ApuQqcd1x0vjTZk0uwJqrXliuAcf+TE5ljyTXoeeytC56zXlNBR7jYeLc/A89xOwTmGh
         mGAkhbawdWfCFfw4d/yZK1KKSw7/Q2/Ts2QJGRMDgcDAtr2nh5KtM33t4LBF0dJ8f3Hv
         DZwycynEyOGNQEcx+KIwSaDQ88ra/zY6xoQU591ttaDF6lKoWEOo+EDhGxoJLY0aJyZX
         S9IvQaaRp3DUGJVMa40kx6HWyhnRYshE6TsMA8KKUQo4nVxrInwQ3jY3h8Tj7u82hI4M
         NXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113628; x=1786718428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQFVxxu807wdaX5Bwa/NPTU2e5DLee4RPhU/5SIwcTA=;
        b=XHYk+QdgrEcowzTmKzQrHKU3qrG8YiFLsUVZecuNyu2NdheHQxYVTp8v460pyi7axr
         sxAvZbM9qyjOOU0zazv2ebjyJTPX+QrpJL/wMX3YuRerwko+oLI7e/FqVtQOQYCtddTi
         w6xzssYQ3pkNJ0cMNAJ/fitPJuHxmlDeaVMp7OLu1sbZBaHk4+X5CjTZRTMReAqg1bIW
         T10eTtfhx1hdNlzAtv/LGl47nqumUlVAe9uN1rzGdi0xznqMQYm3LGtRb31puqfhVCky
         qD/vI5tiB9krfq04m8bOJ6U6lN8IPw0tOgSPH0UiwNjILhxsWv3Q7i6QRU7N/N4E6GpS
         hgNw==
X-Forwarded-Encrypted: i=1; AHgh+Rp27W86gLMFZ7TmLOYtO5svkM0vVJwTE2iErJQxPmn0WkWvxYgM8wAev5ChPqtmpdxE6jIg2p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwwWw2bNrBR85GS6wFqV2t7jnsWh1NErgZ3ljCoCs006PkgTF
	Lrcq7kz9BIyZKuD+eFSPCyR9fRhNmeY6+/MRe82D6Phb1Mc8pILDLpJp
X-Gm-Gg: AR+sD12lQ4MHjuXtY3wACyvZXVYKjO6MP0Ik7arKBZ412C6FBh5vKAowj1GeMMIdMDV
	a16LTNhkmGnjSQwvEM2mBC5EYpHeI4aFKW39PKvOr6aZlaRhq9LEcg6zSDIKMc2AQIzYJedDQNb
	9gGB0T9nBK9UlDA+AIXSH8ot120qZQPsGh3Obgd70fs5sxANt8GvFocwrxYjSMnIY9OrSatygLR
	V1Rq+8JhJz9k6AK9Fa9W+yqLewof0AsTtiamOVlgekqQTMLyBXAdUNCjm6zbgrN9aAQ0zK1Ty+n
	nnTRnC7t4H6So3TNBujLZJKiGC1b3EEAAr/3Wls+uI0YNT8u8nw1qnziBHNtsdLLgx5O4mjAej0
	gtgQmKbMBd/zU2xFXVuM3AdxTlO7ghP6zbcyea2VNn0bBEK6M58jsjV3eFiTHqQX2HiH+8rcyjd
	3CGXS1sj2B5oN0lxIU0+S23ATAHeJPW8zc3TGTA0ewQTrt73/Irdkoo2QDYN1PCc4yG5UOQDdnU
	Ub5prP9gYJjudnZ7vimu0DV+SvQl8EL+Tzm3u1jFQ+vGS9w0V0sUA==
X-Received: by 2002:a17:90b:590d:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-39261f71c4cmr5047859a91.3.1786113628037;
        Fri, 07 Aug 2026 07:40:28 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24b91sm2917026a91.9.2026.08.07.07.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:40:27 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH 0/2] platform/x86: ISST: Two ioctl input validation fixes
Date: Fri,  7 Aug 2026 23:40:01 +0900
Message-ID: <20260807144003.3498972-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two out-of-bounds accesses reachable from the ISST character device
ioctls, both from user-supplied index values that are not bounded before
use.

The first is an off-by-one on socket_id in the CLOS association ioctl,
plus a missing NULL check on the resulting instance pointer. The same
file already gets both of these right in get_instance(), which rejects
pkg_id with in_range(pkg_id, 0, topology_max_packages()) and then checks
the instance for NULL before returning it.

The second is a missing level bound in the two perf-mask ioctls. The
four adjacent helpers that read the same per-level register block all
reject a level above max_level first.

Neither path is behind CAP_SYS_ADMIN. Commit 69cd1ca440a9 ("platform/x86:
ISST: Check for admin capability for write commands") describes
deployments that relax the permissions on /dev/isst_interface so that
non-root users can read SST capabilities, and deliberately gates only the
write commands.

Found by inspection, not reproduced on hardware.

HyeongJun An (2):
  platform/x86: ISST: Validate socket ID in clos_assoc ioctl
  platform/x86: ISST: Validate level in perf mask ioctls

 .../x86/intel/speed_select_if/isst_tpmi_core.c      | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.43.0

