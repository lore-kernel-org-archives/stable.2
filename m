Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636668;
	b=PDYLYcawEPoruGt1/BzTnPdMilcDccc0PNUDGv0EfJWWfENz4rgb31JxlRxcIwIMInN8
	 eA9ntaBXjeNNOl2rSyqUtW2zWVRDbOql9LR39tixfpMtNhDgEHkXmHj2mnJ3QY5TZanXo
	 NVhA4EO6zh/6pa6GU+EClXj6nCQ3TCG06OWYK4DIIlpQ7HgMmSNPGWZA1C7jJICVeFb2d
	 CafwvzAEoLsMYdG2QuyMvaI/Isayk8PRg+uHgrJ33rOYxoNMb/rXttklNNTIfZEouP872
	 aF9e1q8sVeG4R7Mcn7Q8bsJdUyatWAb5ffiUNqAnz6Wqgjz2hH7huen1FwSBwUPMfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZE954/YJTgQdr7KI7FtWvHvLXLz8xxAtjTdUMGYCyGc=;
	b=gqMxq5wTW0cKYQDnib6D7hlW5ElL8WiLEWDLDXwRxKZH+g0Yet2tLFVnVWkmYQdGH20W
	 RKBEIjYswr35JveFsTyIR2rt974RrkseM6STj7kTC1jvKwOkwyYbfo/0jEnAplmYFyHZJ
	 jIfuUM/Nqn8lA8CN8IPOjc9hLahl3s5ATuX6DOjOqWcso81WIh+eFBEZv+DJygnYdCUiG
	 wff8oFHPL/zGP7QCzYXsUqKBcD6N3UHH9W6Ky2U3wejzbtw1GP4DmR5Ova0z6Hp823Qyn
	 uykAyZbzcNxR78qaveLq6mBt5MP4SfKc2JPLCWoZ7J3JoQGg0Rkeg18ZY4Sk1TQtNjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=ERy50hI3;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22617606A339
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22617606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=ERy50hI3
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso8327105c88.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795636667; x=1796241467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZE954/YJTgQdr7KI7FtWvHvLXLz8xxAtjTdUMGYCyGc=;
        b=ERy50hI3pCNQ/nIc6U0RxuIxZn1i7q2FvQ2X/jjjstUcucPFp3fJpkubxtXYhzBHQZ
         YuKRoOYyILiFOikJQdpPGy/+sb6zzaE4glP7hAwdqTGjjDhFoqh+Qqw3LLHGdSAy7i1H
         bB0C+zyGAmZ2tpS+5Jadwro6piASUNZ1iZAmLlmljRNiDLp3J7QDUnKynEzm5HBRryyy
         z3VWzTT4bxaszpTaqXDUNqNbSksBNlkejv3m7sCPfkSAeOOzQ94ccvdwE4lmmt0ez8Wy
         ZitKNtvZWvm5zaezeHjr9/R4chZr1lWKzfOnT7tr3k/Lwwmcw2YSbkvuO5YxoR3sDLP3
         JfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795636667; x=1796241467;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZE954/YJTgQdr7KI7FtWvHvLXLz8xxAtjTdUMGYCyGc=;
        b=VOP77/tiwWPneojUENwi07fuT/2oLCdjzFp4wIlCUtYuKAu48+3Mj5HsWZiIrAwNKV
         U771hvcgSKbeVALtB9UeiGyKY397/Ojh86Wanbuy/+bb262t+ez9GFwc6R6wJQFIYyy0
         AlJx//+aLRZLriDoN6ZVMtyA7O4DSU7jPS3R53y6uoLv6AiK97p5oxIPeRkWrNFKBB2n
         4HxJb9DwE7o2H4H7OwDz8CHBJ+ha81YcDZJ5OAilYkCd4EARSuRaxki3p2bTiaOl8w0+
         D5RAIFX2whfx1aPG4ovcEeSfNH5hp3y7spTwuYLTG/1kEV495SatPxnYHqRGxqRK2+Zq
         XWMw==
X-Gm-Message-State: APuU4Z/bxrC4EUG98qn3i4cukhuT0Q+FqDJBO+b7qfEGjyy4AVwIJEAj
	jdcsIz6a46vCWHW1yNfwv+joDe6GvJVIe3d+H7nHTx1ifFbAUqTAzNNz0LWiQMKJNk29drZjbfw
	5LppQMuc=
X-Gm-Gg: AZFdTZekjxHib1rGXUIjZNlpVI+VCNTAH2YAqcxIxNTysIS1XZYR6esD4M7ijPROTe8
	jJEns2lpG+igUtdut73f6K76WpdX7I2rQm05uNjrh4lzLamIbYHFZ7tWr6RIUr518X2r/AHrY6T
	TXeSQ+S8+diheW1+wn8dt4yd6JLW+PNhK+htpBSu2dW4HniG4cEyXamKQzMagXvjKyh6/4PA9yo
	MzqXl4INLo5Gl1sYudHc4bG0oOSpQxFGwPq6ayUXpb2mSj2tWlM4Flpa2661L25LOLrs2hv3Tjd
	hNuEipZ4CkKJhXuOcn9djUfdjtR15X6Vcn4FwwXYZlIIIoUqM8nGP7YFhqtzbAVTszmpTaBeE41
	s9bg0AQwt+cr/fSijbHRqCE6vQD1Eogz+Ftc4MKvFC+pzHcfw9IVeFhnaLvODuslfXRiz4WTa5q
	vCedhiraGmy8rpdy8U7FNpj+zkYpenZSZN3qBWrBipX+2Odml4nq1ewdfPaSafODnaJFpgJ1WTT
	cHcZYpYz4j8DjKn/VNAAzag3Xj7wdMI83TWf9Uz3vrk0VLFf2KekerapuU1IQlyv0uvk5h4a8uC
	SHEPGyb9sxGuPKXAGorQQHW5UDBDvQ1emiBHU90GmcV9fc9sRQ1jpG28CeL9Fy3Hsv0X5+HpX9M
	jYkTELq5DJKTHVApIvKOCYvuwiQ==
X-Received: by 2002:a05:693c:8953:20b0:386:a70b:75dc with SMTP id 5a478bee46e88-386a70b7837mr12123813eec.11.1795636667182;
        Wed, 25 Nov 2026 11:57:47 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm59596522eec.14.2026.11.25.11.57.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 11:57:46 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: ast@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH 6.18.y 5/5] net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
Date: Wed, 25 Nov 2026 14:57:35 -0500
Message-ID: <20261125195735.57472-6-artem@trailofbits.com>
In-Reply-To: <20261125195735.57472-1-artem@trailofbits.com>
References: <20261125195735.57472-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>
Date: Sun, 1 Nov 2026 19:44:33 +0000

[ Upstream commit 35d2d6e5ac0d22428b2a0216061f3330c095393c ]

qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
offset, in the unsigned hdr_len. A header in front of skb->data gives a
negative offset. For an offset a little below zero, pskb_may_pull() gets a
small length and succeeds. Then a 64-bit kernel reads the TCP header far
after the skb and can crash. Further below zero pskb_may_pull() fails.

Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
tunnel decapsulation") fixed one source of such offsets. Other code that
removes bytes from the front of a packet can leave the same stale header.

Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branch.
SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wrong
qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read after
the skb today get a new result. Then __dev_queue_xmit() drops them and
returns -EINVAL, but sch_handle_ingress() ignores the result. Their content
can be valid. Thus the code that leaves the header stale needs its own fix.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20261101194433.2637113-1-alexei.starovoitov@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[ Backport to 6.18.y: in 6.18.y the function is qdisc_pkt_len_init()
  and __dev_queue_xmit() is its only caller; sch_handle_ingress() does
  not call it. The code change is identical to upstream. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 36375c24b993..4d6f0fe79adb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4152,7 +4152,9 @@ static enum skb_drop_reason qdisc_pkt_len_init(struct sk_buff *skb)
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		const struct tcphdr *th;
 
-		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
+		/* A header in front of skb->data gives a negative offset. */
+		if ((int)hdr_len < 0 ||
+		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
 			return SKB_DROP_REASON_SKB_BAD_GSO;
 
 		th = (const struct tcphdr *)(skb->data + hdr_len);
