Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541789;
	b=l7c1YFPR2SW+rWAYT1vRjAW310PhSgSfTfsJ7neauaIPR/YjtFq0rgfC8zTUlsnfijwG
	 mUzG9xNkpF/4sUX1ArC8sKDIG9faMK2pcqh785iqgW3EvVu/N24zYk2C3x2FeeijkDH/p
	 FihDQg/LQIN2iXRyCBIJrjgtl9vUxgmfyvNKpL9Kgh9o9pAcqUh05+MMHyLIw9dKne7wH
	 wGTi6SK+UqVLu3aUr5s3mG1C2twT8ST5JLTIZn/QJkMOCzamSHzltanaAGZ4f4A00XTc4
	 +HhSgYfN7al9nUG7VDKdJLq1MKQrnM2KG9yd6v29Az08OxAS2ATqEm2vl15XhSLWG+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rbNl23hJg1zhKbb7G3pd1XhcFGZFlCFFFZsOCpK/2p4=;
	b=VP4hTLNs5vlDgxAEGk0Yk6qaj2/cKm/OoRRGE59GE7u8gVM2RcYEbidS2+BEyq3tM0Fj
	 GrZIz6avSYxE9WucMBvqSjwiKeK8ZD5FtM0yG6HYUc2PWv/LdhMqFJEefNodX+qwDRsHx
	 oLrPidpZXauqGRhSk1s328KECFjKYt30grlp+gkjOLCgeH/PKOhSJ4tewrzT7/drki7gB
	 znDi3WxmHbLapQcasu+/tJJZS9qqcMlidOUZtcBxqeZDz38bR102V84ajXtDHHyRog1Km
	 /w5N0cD9wuIk5KqR+cT7iFq8Yy2GyH88UtCsIRzQxGihGj+/016CpgoWL0YxBfK+/PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvctpYzb;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6857606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6857606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvctpYzb
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so38791025e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795541787; x=1796146587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rbNl23hJg1zhKbb7G3pd1XhcFGZFlCFFFZsOCpK/2p4=;
        b=PvctpYzb1u8JcsH4LrpwM+4rqwqAK72f/fTIrzOhUkIixFwHQ9WL5vVg2312aYuVbM
         AGcYgYla9aGPLyNb9IP0fDDKLyQMABmh+NLYEa1i8dty0WVBU1pfZfGDEuP/5sluGNQs
         0S9ZJsNluykyCjIv1X+PSTmYNpePwlqM5WnEjEREFupbPvb95pykVdWtEwH49zPwIPdn
         ZetU2iXYJ2ME30gv71vmUR3Jza0oqC9J+NEW9m56psYlVSSIsBvTVQjJC580s7hlRe0v
         OSyFcfoUZltHJGOhmz7htLKD2i/eI6wfJelNL5LTkxqg2Jt4x3aCtY6u83F6FJep5TCx
         3nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541787; x=1796146587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rbNl23hJg1zhKbb7G3pd1XhcFGZFlCFFFZsOCpK/2p4=;
        b=RuqI1HJRT+2g3jMpr6NkiTV98EWUhaIcCEByJymUExw0+/9u0s+NUXblKGq04BXI1H
         3EXeZYOQxr+onEgVL3oMNwc6fqtbdPH9AhoUhJcMShxUSNKW9ENh4cjDDZQL4PCHqICc
         QjOelHPYl2H+U/HQ7y34vCQYDTjkuMFgJwGOWWXzeno3A8L31nScPoNe2uWzih7Uv8vG
         MJXRIr8GCi1MH35PwdKgzHdwvR8zvvZNDr1uxmGNA+oS/kZ5N/C6WYKM2DUpRYofzGgj
         1RCDpATtg0wzcl/E6CefJ819NOqNUQFqtDFsy/Ag9cps7sjoLhjcgacRApS4J3SIXeCI
         k5eQ==
X-Forwarded-Encrypted: i=1; AL+hErG1nvghY/szYJ4iUBjsv9sUfCQU1JiK9lSjiBPPBGQ/d/+jrSYVH+SAgIQ789WsvX7p9/1vaRg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/suJL+UTdq1SvIvRPGloM1LeZqYc49rKPYEKz/PtsbkHSOo64T
	rtAAHO2vjnWb3XVneLPL+XghAjxpp7Kuv3wZ55792ocIaiRN/ZrW7BE=
X-Gm-Gg: AZFdTZfceWCMvMMjt+j7iPgL1vX3A2q/mkVAx8fHl7qt7v2ke+VqN8mDrnPD/ZMjnPj
	UhBpcSjWN4M7TDRK8GfrzWj8RFbIdIWW7CZm6sdkbyfyyLPmXKjrgIcQK6F50rXwbd5f+ibvS4n
	N6IA4wKTpdV7AMBnN2mRpjzShOkslNjILlMa3UqSrh/0kxCqjANFiWgx98ScBcnlNo492+D5RSF
	p5OqL8pOuoPUd0I/iDIcQkSmbdCGdAUa0+XDU7Lf133zYVcBrlVF90ovbb8Vs5rdYycd35WEDUD
	C0y+GlyzLPR+tBHHhWlCkvr1yBaSJkr9ZF0Gr9+tBbAmYvxnuQZlPYTW+pK/IOyyLVGR28gZc+Z
	HYPD3BkPyvY5A/mFs++iAiRh8j6UlY35/lzLaKsu1gcdUTgMT0D2lgl9WfM3UUtunqgcX2W6cjD
	wXzgWL7QGVskXzmHdcPnZRzXA+XhA6ET6gzhEHpR9ee9P+fDfOghNybx/FhkEyFYuWyx/B1akIO
	qXhy4F8w6xevVtCfrlm487rdqaTGiIBXb/JZU+JBcewBRvETMVQbemFgmQNpwJq96sjuzP6Cdi7
	VgGIaBTuxG1PgrQ=
X-Received: by 2002:a05:600c:c8c:b0:4b7:6942:39bd with SMTP id 5b1f17b1804b1-4bb88820e06mr308628985e9.26.1795541787091;
        Tue, 24 Nov 2026 09:36:27 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm267098675e9.1.2026.11.24.09.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:36:26 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Bing Zhao <bzhao@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 wireless 0/2] wifi: mwifiex: validate firmware response sizes
Date: Tue, 24 Nov 2026 17:36:15 +0000
Message-ID: <20261124173617.802875-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

Two missing bounds checks on firmware-provided size fields in mwifiex:

  1. ext_scan event: buf_size is used to determine scan response
     parsing length but never checked against the event buffer.

  2. command response: resp->size is passed to individual handlers
     but never validated against the response skb length.

Both patches add early validation that the declared size fits within
the actual buffer before proceeding with parsing.

Changes in v2:
- Patch 2/2: moved the response size check after timer_delete_sync()
  so the command timer is properly cancelled before the early return
  (Jeff Chen)

Tristan Madani (2):
  wifi: mwifiex: validate ext_scan buf_size against event buffer length
  wifi: mwifiex: validate command response size against buffer length

 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 14 ++++++++++++++
 drivers/net/wireless/marvell/mwifiex/scan.c   |  9 +++++++++
 2 files changed, 23 insertions(+)

-- 
2.47.3
