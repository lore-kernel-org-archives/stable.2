Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991344;
	b=kR/3N0IVGZPYHY5iTi9s6g3ATifeBhqUIoThVe7Jg9Og7/p0V2NxfcHywGtgzV9ndyER
	 wFVBu2OTv8t039XTEfA8KoS7OoAv8yLYWhkB7jHpD81JZ3/ETm6mH5DHMZdIfpr69DRrT
	 Tq8wRonR21K+G/3PS1uIrPJC2kK90YDbXgnF0YZcsh79ES/Lfo4f/iWhXnw85ZPEReMAt
	 Bi0RBfcqI71aj+8WGQDMAnl2wGnQvRT5rjYf0MWu5XBVIz+oR7sqvwnPN2J37uk5QlxD+
	 +dcBpVHRbuSqQ7hEsWOcakaMHiQxiG0ePq1DfITHasp653ljT/bTe0B68OsWFLFEScQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZGyxnJnZbbXGMPkgOS5KrZfDWbz6ljrwSXVVr6mtPoc=;
	b=l9NiSjaCD3apGqhxEWDO/jAf5pCCoB/Skt4B1NznVqMMurBI7Z7H5lPv6EwF1cnGEami
	 COZ+79KMrJJgqAKdyS2hQ0OFq1hzkuvqjfe+YyUNLKuaRdD9FqkrsmvULmYqfGQCghgH3
	 pyqvn3TB8Mgi+aWeEBFohxg+6V7kx6xo67SXKX/WxDy6Y33i42LTxXpdt652nXgDMMshV
	 Z3n6uRCXleFGL8I2lLPzbAFfbzF9jyKLpmVzySN9+xI3TIZJVhPQ1pFfImvFLe8tGQNRh
	 zetKFZ0meNPg81FdMP+iGeuWp2JhffZKlq0nBNlfsl8/xG5fUZxWvmuUELWfCRe233g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O64ZZ8O4;
	arc=none smtp.remote-ip=74.125.231.202
Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC22606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC22606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O64ZZ8O4
Received: by mail-oi2-f10.google.com with SMTP id 5614622812f47-4f742fc5d09so231169b6e.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991342; x=1794596142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGyxnJnZbbXGMPkgOS5KrZfDWbz6ljrwSXVVr6mtPoc=;
        b=O64ZZ8O4Otw3jQgY45uKa3s7MDVMBUfVYcPhZ0dL85m++Y0nU1g2lW5fpiMjaCul0l
         SeKRwKGkTwguv59Rjil8siP4CjPFaWgDeN217uY0bE7ZfqG3KF0p/e9TiYdja2PjsybD
         nggmuNsFpbjXpdot4sLXJ6Qd1D1gSon74JuxLtcx0e+hpsx+c2/CFEqHp9ZWkZ82Iso4
         uWwv1yEwR5S9GKxA5XlfjzJWj5Uhhs2kRmGBHZ9ojPs7DfYcpn7JRmATCBL/SDt6Y5mO
         94lqsgPIpDRe/DONK5J6RyWZUC+ikfnGzo9aFEuB/Nya8u/Qp6OoUbnApbcknwZMEyhv
         ZrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991342; x=1794596142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGyxnJnZbbXGMPkgOS5KrZfDWbz6ljrwSXVVr6mtPoc=;
        b=xLFAAWhDzkQuBg4vFaBpLGNEToP2Tak1F3SJV2RMgteUrcS9NO0///ucK7X+A+jM6j
         DE5WchLsg+zvmIIokPDl38TzLua8rJbeI0g1bBSHhP2HMhmF6EIP3YRBh1oEfGEgQKIF
         kWtMs/UDdo4N28i19vXbM8U2lKesBuoJxq9T7pgB9DK5WKJyjWr7dfmc0cZgA7W0Ilqi
         N+DXLNQIUDl82PYZVJAkA0YMTUIIhSmWQW+5gQ1DHVX0hn3ECB6cTI0oOyRWRuCdEjbZ
         1ZNLT0Lw2gRiFuK/LmuOD017rUvF3x0dqV6tFv2LaqnNrc5lZGKnkyTY3tHXUixj7EIT
         D+/Q==
X-Forwarded-Encrypted: i=1; AKwUvBw41U8Rux1y68WfjZQuWYI3EkxMk4UEyC8IpT/rHvx0obzA7bxyb+DNuJtyKhniAw53Ka3E8A8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Q9ay0LMd78BWd3mZB8lKklKbHTfR+nKfkvLiLuB70lP9PF/lS
	sH/jHxR/2bSX4JW4xYq/kIjWk4eFgowisA/e6qdeLyaF7Vm0rEIW3ax3
X-Gm-Gg: AYBFou0FAGLWkpTbGSZqpiEP8W2D31Mrh9eAevRLADeNM62+LiVnEJRgHMSkrVl1qsV
	nDbZ4/s7q3zG1zY5TzCMTsuiQrx+fuRNdvwTSpkWULzD8dDeVmUDAqWiMrjBQ3EAhvCz+ZMR7b7
	S2XfHKSDJBgOPyd1hhbAgVSoSBeTOIi3trxQnrsVhtW9/UvnYhnTpdwWUDYOujTTWF3UrPJ5Wcd
	gc8AliNLsZKNw2PTPp6+cL9rTf1jouo7wyLifHztZIVJa8PEFnJfcgGQ6Xc9D5SyWOzVQCPbQOo
	PIN/0cdKOxgKoyDVLxMdDR1E/2brPwnl90NEdA9Hvm8Q3OSBa2BFcrnMADQGR0givdgr3glaix6
	9cOzSwlm5wwaO18QC7NQwOzkHqV2i5Pzr13exCFslCetgjRf3sXnAw403t2u49HtnWCG0Ao2gxs
	0gLXb/GV3PN+9lie1pKqwBC1LaXJmrBHbC5pePwT3xjLwHPBQRsXqAM5m79ZK8DuAlsK1EYg/y3
	Rn/6+75OE4i/qMSBoKzgO/Ts5dpiRA6JJdiCCDV/UOHljJ8SOwkA2dKSDGq6zr2si98uLjYkzw8
	9tln2QQgSMOrNFVFUNiO/W19ur4cJdQvEZVMvDk4CS+IJShgWzN3Lz5znj3f9unQ8ztN
X-Received: by 2002:a05:6808:10d3:b0:4f3:36ff:e521 with SMTP id 5614622812f47-567e13f9a5dmr2809962b6e.58.1793991342161;
        Fri, 06 Nov 2026 10:55:42 -0800 (PST)
Received: from localhost.localdomain ([14.116.239.41])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7e70338sm2162164b6e.12.2026.11.06.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:55:40 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] apparmor: fix out-of-bounds read in unix socket address audit
Date: Sat,  7 Nov 2026 02:55:32 +0800
Message-ID: <20261106185532.3338123-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

audit_unix_addr() logs pathname unix addresses with
audit_log_untrustedstring(), which sizes the string with strlen().
The sockaddr passed to the LSM hook is not NUL-terminated:
__sys_bind() copies only addrlen bytes from userspace into an
on-stack buffer and leaves the tail uninitialized. A pathname
address without a NUL byte within addrlen makes strlen() run past
the stack object, and adjacent kernel stack contents end up in the
audit record. E.g. on mainline (05441d697f7f, KASAN build):

    BUG: KASAN: stack-out-of-bounds in strlen+0x93/0xa0
    Read of size 1 at addr ffffc9000287fe98 by task poc/1004
    CPU: 3 UID: 1000 PID: 1004 Comm: poc
    Call Trace:
     strlen+0x93/0xa0
     audit_log_untrustedstring+0x19/0x30
     audit_net_cb+0x3cb/0x760
     aa_check_perms+0x19d/0x340
     aa_unix_bind_perm+0x73a/0xb60
     security_socket_bind+0x2c/0x60
     __sys_bind+0x103/0x200

Bound the string by the address length with strnlen(), matching
the abstract-address branch.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: c05e705812d1 ("apparmor: add fine grained af_unix mediation")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 security/apparmor/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index 136d14226b97d..cc8dcc5bd619c 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -86,7 +86,8 @@ static void audit_unix_addr(struct audit_buffer *ab, const char *str,
 		audit_log_format(ab, " %s=none", str);
 	} else if (addr->sun_path[0]) {
 		audit_log_format(ab, " %s=", str);
-		audit_log_untrustedstring(ab, addr->sun_path);
+		audit_log_n_untrustedstring(ab, addr->sun_path,
+					    strnlen(addr->sun_path, len));
 	} else {
 		audit_log_format(ab, " %s=\"@", str);
 		if (audit_string_contains_control(&addr->sun_path[1], len - 1))
-- 
2.43.7

