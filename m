Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296656;
	b=YCQ6K0JeXwL5MIgW0FWyZ93OC4ZsNmdz32ibmM1z7vPpqgsVg+TXsvOi0tUc35ERx9eq
	 +n82YtS36+9hb+mllnWtNvnvGi1jNW2GWzCmxuU90cWPcko2SbKP57j/4nKMHB/eSGF4/
	 lpRE3wVYfQaMtHuPQTUwvNRI4O82CIbziFUrCNNUqDCVdGn+mH+Caxi3nsmWL64tNncJn
	 rYyGXTikk9R2HOoAJPNts4cUAuyeQNPpfPIo4NqKTfzJDq/e1Giu3kg8JlsN598rHdJX0
	 8k0fxB0SNFnPwiJGXeSkgbDNl2Qcrz5SDWdbvTQGwZSh0bjBUXVaTVT+JfV+FrhEntA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=21u1hpIC5EUWJTnpvNFV2a/hxCKKBoH7YbnCmrP9J/w=;
	b=AKEx9OJ3H1PGoARPj3we9NlBd0Lh0E0I3RWGDK6gp1aXacBR1f26OSD0BaNbf12uUuZN
	 wgW8YW1QOJEQieT01QTVWsH4fevy9hXgq/ycmWqMI5RuKp7RZLT13YhneWqMtc6gi9fcN
	 K3ezonR434PJuU2S1B4Fv4WDsmmNNh6l+x6oZqONsy3AtD82NusUxiCyhTkDiiJv8pYIx
	 Qx5RDxomjB3BiQ0CchU3msuGC03Ms4s8JLmNBAn80aoWfW65HLn9oLDN2vcfUaxeyPybF
	 7A9RlLyCKyMJTjhvrXIl3Op8fOOj0LUym+n5EZOiw42i7wLMoB4dBFl6WCgL5DZzycg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=h+3GINY6;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A27606A335
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A27606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=h+3GINY6
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-71acdd32a53so850261eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296655; x=1795901455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=21u1hpIC5EUWJTnpvNFV2a/hxCKKBoH7YbnCmrP9J/w=;
        b=h+3GINY6EtUPsxavkUc7hUxj7a3j8s+shkRoLaUUsMTs9Ijn2TlHuIJWtJY1G33qJE
         w1F53+Kco/Mz+cJG0rDQlkjP5s+SHvapoqpa4R1C2Tlh7bDB6eZcuZBP6eEQqGqrGrgV
         YzJlaQbjzWIYe4FbHDpl7CEFVG+1mzbhkU+Ync5K0+QcT4yFf6arFRDk6hQDrDoOW1JS
         tso60K5/bmfZo7WKvTxn2DwhFmpPCrqOKnOfOLcNI72zCfftBOcNa9VtbkpnfxDYpcgs
         /uSeYn5mTgYcQrvze8vTgzMwH/vQq/bAfWHw/vja9Vsfkpon4TjHV9dC3wCj/pTrHln+
         guNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296655; x=1795901455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=21u1hpIC5EUWJTnpvNFV2a/hxCKKBoH7YbnCmrP9J/w=;
        b=Lh7nAlEp/8hW4+qfd/zLj2N26g/egAvvg0NUFAMs50M5iHb3O3BH2pCa5GnD726li7
         WuoTvDJeHZkElHi2J34wcb2fBr3GS1K5r9x4kRB2rKYE+MflQ63mTBpTq0IVE9LdJpfQ
         zFUH97/DmR2IweivqvOOKZPL9gtUe9Hf74Lj9BYkE44y5w2Waw10Iu+cTjPmVyivow2t
         i5RIze8eV5Md80iM0KkoNujlGxo3KNMbQuHyXXoUSdFAgsbreFJk+Ky6WsRHPIcmxD6W
         GknvL8+9LjVxy/dIzsrPMmgJOM2QuGUvecyaL+4RO2+zPcdar5g2wobulmFgsXvpDyFV
         OSzQ==
X-Gm-Message-State: APuU4Z8GDeeDsM11+EAsZ8Al/lYb9Gv1BuUvO0mmNCT6KHe5Zp8IzH+3
	+SvzpVZxtUNfRQJXuhEnCdMvwVzqBzn3mnA6dHYojcUwisr659aFz5DiD9PjjLZVX9tv5uMthzB
	Z4+cL1Fc=
X-Gm-Gg: AZFdTZfeBwF9ZF8yjPQKGZezh0FDGbyFQPjouFpWElz0UOqqxoc/Y/U/mVfEM1OT1mG
	e8senz2SGmd6Z3u3o0vIADQYNw3loTBWM5FnFXHJrwfGCP8tjBA52roRqVHuYGSeqS+9WpuszLI
	CNFxG4DfvCdf995/0FDgrVl2fSXCcAjUU5BeR3qXa6OGaHT+QonsrzPlY+KLUZ1tjWJC9wJmYe+
	QmhaKyylWj2zGiD5Y4NaTKoHycvGEX6EQpG7uH4q/VLbXnBHerdR5611Tb2fs2t53HXE3xO078V
	S+Qms63UpROBCJJj6fKdwFbRgzUcBdzik8W2RlE2tx8zDx8CxJMdLvA80oCsJggWPfVb2N7ZHck
	i/ExaypeLbBHDzSI/A13ReLWw+nqtSj8x3RCu1BiY7DOOypNToePMKeQvCX0AFzspvbJIlwKoLV
	qzNtO5Sojfx8B1aSlfynzQtXrlMmNCnBX2nDQObqCBpnfadjTgdo4xHI+N060EMjwLCoWxN0Bd8
	agWXvKcz4U9gBJ9ig41P6Oz3bwkLmvRd4ZOAdZCa6ilzjOo3SfMJr6AzL+WsE/DfdG+a3Q7neq5
	62xmWaQZvv+N4IZ0G6pxiO44G72KK/lNo5Z8iYYcoCG0HqECz/LkU6FsEw1GxHf+4iP6zy1pqtD
	jRgeiRokiMoErIMk7tdn4aCEtn7BiRyBvwLJn
X-Received: by 2002:a05:6820:1517:b0:717:da:ba24 with SMTP id 006d021491bc7-71b39590c9amr5782585eaf.76.1795296655365;
        Sat, 21 Nov 2026 13:30:55 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.54
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 03/19] io_uring/rw: fail soft links on IOPOLL short or error IO
Date: Sat, 21 Nov 2026 21:30:33 +0000
Message-ID: <20261121213049.1788332-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

Commit 4d3db66c5363dcf42c3d43ebaea330ac2d1888bb upstream.

io_complete_rw_iopoll() updates cqe.res when the transfer does not
match the requested length, but it does not call req_set_fail().
Soft linked requests then still run after a short or failed IOPOLL
read or write.

Fixes: b66ceaf324b3 ("io_uring: move iopoll reissue into regular IO path")
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20261114072246.741950-3-yangxiuwei@kylinos.cn
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 reissues from inside the res != cqe.res branch, fail the
request after the reissue check there]
---
 io_uring/rw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 102f92dce672..ec8e719a9386 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -318,6 +318,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
 			return;
 		}
+		req_set_fail(req);
 		req->cqe.res = res;
 	}
 
-- 
2.55.0

