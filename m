Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8337F315
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214753; cv=none; b=LIbqGofgRNTG15IjNDKKic+LIYkJ7X0QqmS7NWzLJ3CEZmQjopF1WecsHrMmMNkzxc9jliWd+AfwWJ0EP3lXNS6FQJ+tvLoypvHLi6Fcmx7aQsq6NrcT6+E1ztzKoiq9ys5DxEFNDBv3BzJ+8upKGF7YVNfbMP+/gvwI5MbK/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214753; c=relaxed/simple;
	bh=QJvpPZ/MRHEPiELxTYOq1HgO1r8v2Ya4Ct5faQQJAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJlyQKorrahbMKR0Zw6jAFTM76zcEdsl/SEIyMkplzEaAuvnoO/8DzJUl+vGm4PxACUpQD2TxuPHDLjgbVErzG2j7A+Rz3VMdLlZYU2PYewaWdpUfGo8n5MRIYDRi2GUccLK25VFL/oeX28d+uFYFA7KEadLnEWtcum/WwjDzDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ej2fSgYv; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej2fSgYv"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bcc0c495efso911696eaf.3
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790214751; x=1790819551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QL7ggWRtNIdXL5Uv/0YUEwuqXEODJnZlZOBtu7H7FUA=;
        b=Ej2fSgYvIDvu4K3rl3CVkvaQDYRczxMggASq2zogrJkTs68frFCWzAqixBBM8l738R
         TjJYPAodYu0GgyQZspw9XzldaSklmW/eVL4qSysuclAtphiGqriOyusjL0zzYU+w3Ubs
         QoohskuB4+OAj+Ddg8BX606HA4LVmNVXnN6T9SB5AVnD1I9Jm5YgMZ4MijkKTxp8el83
         jtngD2XFjOhOXWK8INgK6UxxXhantLShGE6bPcyD6fCt8jXj2UjbMnuSekzQwbRnO3Ks
         7hTKYiBNUGL1aQ8GZ7qlEn29rOI/22XMH3lU17Xq+YcSXuGtUPZnQ0nMQ5jHATcDdbB+
         b6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790214751; x=1790819551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QL7ggWRtNIdXL5Uv/0YUEwuqXEODJnZlZOBtu7H7FUA=;
        b=lmyUOtc8gtb1wNCO5Upxt7WuuwEgsxwC4iUJs89Yuc0l+1RWK893Tq9syvEizUSp5A
         SahVdCVCYoxf5X2gLS+Y/4fwkO8leUDv00UkeKvCm8uOxdTzZekeHF6yHlKD8PVxkirM
         RCxXs6MXARCmOEbyqSLnoiCROU8Mjdc+pPl5R71Ne5mMw4XqxI7IWFoW0sN+HGOR8sR2
         kFZRHj72/axqlVYiPaUNgG9Xu986S1zjQZrB9dGCIjlavgeK2D3Wi6RQDwvl6fHkSapV
         AhhhOIqJRxAeZ+DLtD1Z/9BIpljNKF6q5JVBgl9IBMBYrPK0qyzMc2pxjyHq2K1IMP0G
         nLGg==
X-Forwarded-Encrypted: i=1; AKwUvBwptQyspdr3evP1YPz56hYi/rZBUqw5spDXAGa+c0krQv4q7gfc2S5Pc4izqbAlm413SL0qxZE=@vger.kernel.org
X-Gm-Message-State: AFuF++nMrphyAc2sSYYmrC2pxe0miwCG2S3V6ARhjdCTmjscY7RF8Gkh
	LIfqTe88BeQcodQeiwYder2K8Yl1liINnnhP1ekdPQYMeRFUHYZJNX+G
X-Gm-Gg: AYBFou2lxru5vRoIAZfubGys1rQGvmETzuiEL4ecjJz7y6sry90Fq4yZpg/rRelYptv
	yRxo6QICfowr/c5zwIhPqx5Er0VpTR/CNQzoaxXoMquvUSGddUF7nbSHCbQPpsqBbyAc2V3gK93
	gT59mQ8RSL6kDGI7qfiSVGi+YU+VdIbmhyUqbF2taxL1x0hgzeCEwvbqaxVA9LG7JOgjwg5euxf
	bczW5DHLLfFraGdPtJ2yldPUuiIpNNMI4LkN578+1bqblroKxbo2LJY/X3/KhCvi01knCz+510y
	ehHiYfL+GFCVYICOHtE08JoakZ9uj2a9J1/PUTcSdU/DmIDJTTelarHKXWdV2VoZ55va40TPj5b
	qV/mzfwHYwuoHjGcgIBhYrsTLbRilG/gIzpcsRk15ZRrnYWuiXWgAE+/+3HBNOHy4vo/r1fzF/s
	DMI6Ic/10LSJk7XAvPlS1nf+de5FHTsDJBXjuqIV616xtfGgtiSi7kAfOvjTikM0wDiCpgKPBfG
	dXomIJhXeEZXcdehAr2i++/E+s5WwuMy8xteXSi
X-Received: by 2002:a05:6820:162b:b0:6c7:96e4:3539 with SMTP id 006d021491bc7-6d4416aaaf4mr1160260eaf.60.1790214750652;
        Wed, 23 Sep 2026 18:52:30 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491ed1ebc62sm1057379fac.3.2026.09.23.18.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:52:29 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] tools/nolibc: fix FD_SET(), FD_CLR() and FD_ISSET() on 64-bit
Date: Wed, 23 Sep 2026 20:52:21 -0500
Message-ID: <20260924015222.31693-3-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924015222.31693-1-danishkhateeb03@gmail.com>
References: <20260924015222.31693-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit feaf75658783 ("nolibc: fix fd_set type"), an fd_set is an
array of unsigned long, but the FD_* macros still build their masks as
an int or an unsigned int: 1 << n in FD_SET(), 1U << n in FD_CLR() and
FD_ISSET(), where n is the fd modulo 64 on 64-bit architectures. So:

- FD_SET() of an fd with n == 31 sets the bits for n = 31-63, as
  1 << 31 is negative and gets sign-extended.
- For n >= 32 the shifts are undefined. x86-64, for instance, masks
  the shift count, so FD_SET(40) and FD_ISSET(40) use the bit of fd 8.
- FD_CLR() zero-extends ~(1U << n), so it also clears the bits for
  n = 32-63, whichever fd it is given.

select() on fd 40, for instance, fails with EBADF, or watches fd 8
instead if that one is open.

Build the masks from 1UL.

Fixes: feaf75658783 ("nolibc: fix fd_set type")
Cc: stable@vger.kernel.org # v6.2+
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 tools/include/nolibc/sys/select.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
index 6d65d9ef3d6a..f299c79939f5 100644
--- a/tools/include/nolibc/sys/select.h
+++ b/tools/include/nolibc/sys/select.h
@@ -26,7 +26,7 @@ typedef struct {
 		int __fd = (fd);					\
 		if (__fd >= 0)						\
 			__set->fds[__fd / FD_SETIDXMASK] &=		\
-				~(1U << (__fd & FD_SETBITMASK));	\
+				~(1UL << (__fd & FD_SETBITMASK));	\
 	} while (0)
 
 #define FD_SET(fd, set) do {						\
@@ -34,7 +34,7 @@ typedef struct {
 		int __fd = (fd);					\
 		if (__fd >= 0)						\
 			__set->fds[__fd / FD_SETIDXMASK] |=		\
-				1 << (__fd & FD_SETBITMASK);		\
+				1UL << (__fd & FD_SETBITMASK);		\
 	} while (0)
 
 #define FD_ISSET(fd, set) ({						\
@@ -43,7 +43,7 @@ typedef struct {
 		int __r = 0;						\
 		if (__fd >= 0)						\
 			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
-1U << (__fd & FD_SETBITMASK));						\
+1UL << (__fd & FD_SETBITMASK));						\
 		__r;							\
 	})
 
-- 
2.55.0

