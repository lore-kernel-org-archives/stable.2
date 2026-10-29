Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262254;
	b=HKiAjXzzMZOahVPfFnqNxy4ACt8qyRyZ9M9Qgcw+6TBXHkU0J1ozXdUM6jiAjGpuf8bw
	 3W2gUIAzs5qCgk/ZNlZjDSFIiXd2vnK+0CYJDSvWFAuYnm8bb7dQ0JC8cWUdLgyeK5vao
	 KgBGF6eLvomykvEh0ePLJL2AgUNOvYiztkFfJXc21H3GCGotaEEWdRze/nCw9lP4y3BYv
	 8TSBjd06O3IAcHT3DDJT6QI4vlvZvJ48K5gcKErnmVUSnZuGZ6h0Wuioth/9GolqStAFP
	 BV4TeuXGSni5ZQ8jqXjITIFSgsTsVF8eNUlD98JJhduRGUFaPLzT5j1fWDWOshuUHOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jl62TfhWYAfPnyRC2G3aSDjU5xgDd+P3RO6y8pPbcO0=;
	b=kHGU/KPeqvbUtq7YqcrfGv/4gwA4vCpLIVtKJc8R63uUYiYSl57v6t4OOpPUtt07tfFR
	 sHGxJuFIwQdJ5MWgI+aJkarhSvZSSM0a6GDh3ere8wFo9OF+7oIiNydOrZIKilnH9CQ1i
	 pt9W5y8+PWn21almufucEfDTYbQAclDj4c1aYSB9xDQjzcKc+NM6y5T/UakOTsqbt83Hl
	 MQbE59nTrzWa0VVf94rIHJwY41qIpg4dD7VTCzJllXIMtuNTGz7DWDGb0ANPm9h6ZXwiG
	 TuPOKBC+O4V7I0i6TlhVwMefMO0Dc7M6VhxB7tdbhd78i+vIDLHIc7wPq9XENpsMbdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=logictree.app;
	spf=pass smtp.mailfrom=logictree.app;
	dkim=pass header.d=logictree-app.20260707.gappssmtp.com header.i=@logictree-app.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aE6JFdCC;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1105606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1105606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=logictree.app
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=logictree.app
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=logictree-app.20260707.gappssmtp.com header.i=@logictree-app.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=aE6JFdCC
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so879615a12.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=logictree-app.20260707.gappssmtp.com; s=20260707; t=1793262253; x=1793867053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jl62TfhWYAfPnyRC2G3aSDjU5xgDd+P3RO6y8pPbcO0=;
        b=aE6JFdCCM7LO9HwJ3nmpqUEZ5Tb1xgSgczp0QUjlpVLgv6TlMsf7w3ivWhK/vnw1TY
         +N9kasdgbbSCGzA/mfKxrMAhdiEuOwQGGkqAD2PIPoN/rrU1wROWH19hksp/yp6O80nd
         U2O3Kcxx37NH+woPi2x7cUkUqP3Zv/lp9vjbZ/tpn7ssENonLbqcLASC4spNRBAJd1Xj
         IDsiTiAeofqeeYS1NzAmrZNvedePS03zVYZRSOSouqNQ8mH85lOOl5sR3H9pSjdRiK7h
         y8oA1nrLpQlAdTsLnz4VxnsowpJpdzhkPkyXr8Op8OHILm2yhshgYxD88zCaigM47yi/
         mTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262253; x=1793867053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jl62TfhWYAfPnyRC2G3aSDjU5xgDd+P3RO6y8pPbcO0=;
        b=gZ4sy75ToliX6GDNu55mTqRS/7PpYNGtF4NeNQnjN1IPhEGJtle+cIef0ZPGJdjZA2
         9+aY804RJUUkZG6RLe3qMSUQOXyR/zX5zGPWVkJDt69NT/fvMzUB3Rn1Kao2HIE5v16J
         K+YKLrUoS/6EX4khpLfF3dDeAp6CqOXW6/MLm24dNct5etUJ3P1BTFqr947Qu1hUrgRg
         t9VM4oo3VTbWZAak6ncGXeOMoI5eiVWT14/qbgTW97DEYyx5dKSmPUrrQkEUuokY4Nq+
         T34OS+/7vfbLQvQ9yJeuMtgxnEqa1X9BR/nYfRuP3VdZcV/WQvKpPoroNc6lh1YdIEoD
         d5sw==
X-Forwarded-Encrypted: i=1; AKwUvBwlQijnio2tgeL1NgA1te1ihlRw4uO7RSQRcf7BNCp1vBhtgKYdpCeVxllIh/fZQbLKdteIE2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQqO43hxz5Wg4Ssv8u6Db3QaMXhaeZj9rWmAK3U/XGF+Rvj3Vi
	vZbcSufteNJVCgLFHMJdcpwERw/Dx4xZ0J+ZNxIk40Fl+dabEOWgUeIPpZzg+8oJo+sc
X-Gm-Gg: AYBFou2V4I7cMd4IaHkojR2zf6G4J/D/hEuDEdDdagfaBaddvJBI2PNYVRTTKKAleWT
	yeu4D31B8SbXthVypMKNsxnC78g2UHpslqgSYWTdbooY5XR5HzPKwsah95FMaArFDgP8xsX/kTV
	VmCsj7phpjgHOCzJQlL4XaLVXhZA4mnJPjxumWqsVFNhJUIQEFEYdDJBgljd7A6wQ+/DRM3IzCE
	BhM9pCL6PdczjeyvnJ1noaXpiZ8IkWHr4EU9BiRYz2CggPCNGnvhReSabC0cvrj4GvEYVvJsOeh
	+m9dKEieZzTFGmaSnnBQrrOM9xi7FuZESUUn+j8kc+ttY92fjaGQPjmdo1QsS+LxT0opEXDkZZW
	dl+WNGwEqo/pNJNvKOZKypadFtoH+wu8STEXOS4955SJnvPxQujGjMkqnu4ux+EOVBJKh3kngx1
	s0xhduFUIw6WTaO37qnnWDmiPf0lF0LswIxfQ53SaZZ+ysXB9SZhujdMQBZPopkDbRToMOStCIp
	A4kKdJlWI+4zAajtbrgJvYpU6/4TehFDCCiABzCy6XV2/xBRfvP3t0mp6e4bpEuFeSzTkzgy/Ov
	BGyhWWqM0o36hnD9K6oNPLiszZ/QbOmn8s8zzT6NhHpy1vy4IcVguIAC/TOFeuaFE6eNk8CVu83
	sdghe2CXDC8VoMW9Xfpgi/KO6C5kBIB3bDKN34vLhmkJz2Xhqix3JZzqDqST7QVyqIcflI+iErE
	enRhXTK93wWw==
X-Received: by 2002:a17:90b:1c8b:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ae5817e0a6mr3383992a91.45.1793262252637;
        Thu, 29 Oct 2026 01:24:12 -0700 (PDT)
Received: from localhost.localdomain ([1.251.203.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7f9cd0sm3150530a91.6.2026.10.29.01.24.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 01:24:12 -0700 (PDT)
From: JaeGwon Go <ceo@logictree.app>
To: linux-usb@vger.kernel.org
Cc: westeri@kernel.org,
	andreas.noever@gmail.com,
	YehezkelShB@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] thunderbolt: Send header-only XDomain properties changed response
Date: Thu, 29 Oct 2026 17:18:34 +0900
Message-ID: <20261029081834.91559-1-ceo@logictree.app>
X-Mailer: git-send-email 2.54.0
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

Commit 19813551701d ("thunderbolt: xdomain: Avoid potential stack OOB
read") turned struct tb_xdp_properties_changed_response into a union of
struct tb_xdp_error_response and struct tb_xdp_header, so that
tb_xdp_handle_error() can safely read the error field of a received
response. tb_xdp_properties_changed_response() still sends sizeof(res),
so since that commit the response Linux sends is 36 bytes instead of
32: it carries the zeroed error field, and its XDomain length field
says 6 dwords instead of 5. The other responses changed by that commit
are not affected, because their non-error members are already larger
than struct tb_xdp_error_response.

macOS sends this response as the header only. macOS 27.2 (26B123) keeps
re-sending PROPERTIES_CHANGED_REQUEST when it gets the longer response:
after link-up it repeats the request every 1.5 s, ten times, and then
resets the link, about 15 seconds after it came up. thunderbolt-net
logs in and passes traffic before the reset. The same host stayed
connected to the same Mac for about 23 hours while the Mac ran macOS
27.0.1, so the change in behavior came with macOS 27.2.

Send only the header again, as before that commit. The union stays, so
a received response still has room for the error field. Linux
requesters accept the shorter response: tb_xdomain_match() requires
only frame.size >= response_size / 4, and tb_xdp_handle_error() reads
the error field only when the type is ERROR_RESPONSE.

Tested on an ASMedia ASM4242 USB4 host running an Ubuntu 7.0.0-38
kernel, connected to a Mac17,6 running macOS 27.2. With this change
macOS stops re-sending after the first answers, and tracing shows an
8-dword response with length 5, the same as the response macOS sends.
The link has stayed up for over 1.5 hours, about 80 minutes of which
carried a multi-gigabyte transfer every few minutes. Not tested: a
Linux peer, the error response path, and macOS releases other than
27.2.

The analysis, the fix and the tests were done with an AI coding
assistant.

Fixes: 19813551701d ("thunderbolt: xdomain: Avoid potential stack OOB read")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: JaeGwon Go <ceo@logictree.app>
---
 drivers/thunderbolt/xdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index b187a60..563a8b6 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -509,8 +509,8 @@ tb_xdp_properties_changed_response(struct tb_ctl *ctl, u64 route, u8 sequence)
 
 	memset(&res, 0, sizeof(res));
 	tb_xdp_fill_header(&res.hdr, route, sequence,
-			   PROPERTIES_CHANGED_RESPONSE, sizeof(res));
-	return __tb_xdomain_response(ctl, &res, sizeof(res),
+			   PROPERTIES_CHANGED_RESPONSE, sizeof(res.hdr));
+	return __tb_xdomain_response(ctl, &res.hdr, sizeof(res.hdr),
 				     TB_CFG_PKG_XDOMAIN_RESP);
 }
 
-- 
2.54.0 (Apple Git-157)

