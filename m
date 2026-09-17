Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7D4DEC3F;
	Thu, 17 Sep 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663025; cv=none; b=qmxi48saw17/Iivvp4/0NfMmQquEqeJ1oFogzhAvI6Rr1toaNbEr2FP7vHWONQqqNvq7BzUZI0sWEJB44NxOIBpEikI7Osg0+6EfTspoUkjPrJGXBoGzbbjJClH3o79fnTwQJnquBs2TRorJ9QZ8CJB+z8KBmfK5PRp4fHLacsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663025; c=relaxed/simple;
	bh=1Cqchuek7oF9deUtMi74R8hULx9w2ZPZpLTHkHJ/oJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZfwjiFMBjf6uPhlwTOnpX/UWqkXXaPfSRXV+7lagAcUDNdiuMRqc6dH2//x/tXlOe63B7Gss1kwx5Auw/178zPBRETJv5JIneOA2enavmCr4eI7ZPjeKTaqxVVhM9tQjeQxE7D4og5U4HS+QOGLijrW/SLP/CL8e/ZmLhXnESa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHtD4oF6xq55qECA--.6836S2;
	Fri, 18 Sep 2026 00:36:56 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: davem@davemloft.net
Cc: edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tom@herbertland.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] kcm: Fix socket use-after-free in kcm_unattach()
Date: Thu, 17 Sep 2026 16:36:56 +0000
Message-Id: <20260917163656.2162621-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHtD4oF6xq55qECA--.6836S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xw48urW5JF1UJr1xJF4rAFb_yoW8Jr1Upr
	ZxKFW7KryrJr1vv3Z5A3WDXF409r47t3sxC348C3WxZrsY9F1Sq3yrJrWDWr1UKrs5Krsr
	XFnFgaykury3Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr
	1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAINA2qr9nBOwwAAsK

In the unreserved path of kcm_unattach(), the reference held by the
psock on the underlying TCP socket is dropped with sock_put() before
the socket file is released with fput(csk->sk_socket->file) and before
release_sock() is called at the end of the function. If that was the
last reference on the socket, both uses access freed memory.

Drop the socket reference only after the last use of the socket: move
the fput() before the sock_put() and release the socket lock before
dropping the final reference.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/kcm/kcmsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 3912e75079f5..b3838a19f0a7 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1457,9 +1457,11 @@ static void kcm_unattach(struct kcm_psock *psock)
 		mux->psocks_cnt--;
 		spin_unlock_bh(&mux->lock);
 
-		sock_put(csk);
 		fput(csk->sk_socket->file);
 		kmem_cache_free(kcm_psockp, psock);
+		release_sock(csk);
+		sock_put(csk);
+		return;
 	}
 
 	release_sock(csk);
-- 
2.34.1

