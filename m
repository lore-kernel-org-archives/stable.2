Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D92475CF
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905769; cv=none; b=T7J9uA5Ym4SiC/nnlA5g1VLVRvoYA1s5abmsuinCURe3A+/XJXaGxA9nVHidk+PrQoYZte/Mchc9tWe3ExhlVDxIZzkDkG4btNlmlDA01zl82AnR9j0UWeSUf+/wX9ftGEy+b5j0MOHbRMrKDPMQYJRb6zRgSt84R6Ujjh2aYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905769; c=relaxed/simple;
	bh=r68fvNfyB5iq5zgmcYtQh4f4Sqo7v+mUf0FuLyud6fI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9vhDT9/OR0QoyBmlkIHoWGY9RLftd3nnZyNyIn0ibxIpvd/HqERPqQUROsd7VIcAsoO7vMCgMBI19Of2CYKT3suJKXZgZpeIzj1EOamk6ZuOgAYYSOVywnlVToj88wf1LFfMt7tDdWGMlE5TV/JQBUqlsTQQeq7QHK6AMHXQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3YeyoM1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3YeyoM1"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-90327237340so14620876d6.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783905767; x=1784510567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NTLeZyR0HQahPotCRM69u6fZXEm2pgRfmSKzmsE+130=;
        b=J3YeyoM1w+6qxDuYW43WQT4HAXKqRE5ettOOO6O4AWpdSWrJUqNDX8NRabrHbapzrW
         YCPgqiQJZe0Sltd2ORUggUwSgXpjIGaZhfOAfzBzbMAfcDP9+C8gWDTK6FpQeGkuha9M
         4rc8ywj1QWcTb6NTlwsaDKvmn02gJfUTS+oLu+FnbDt1aenvwgjiZUr8ImyCbbh3Iy2c
         5AzBGhlAdz1GyQ54UWp5nWJ+JpKLw/0RErzDI1ZPkZoOca4MdJQCYgclC1Rpae4Jaefd
         PQmuQeBkjDKbldd3N1LzBoVHD1Ni/onM+hJ8KDWDqZYoN8GTkVpzA+Si4MHd1I+A+ufr
         BRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783905767; x=1784510567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NTLeZyR0HQahPotCRM69u6fZXEm2pgRfmSKzmsE+130=;
        b=ldv5q49bkQrWAALjc6pP2THFwEa+BHFtv19rqmqwZEbSu7qjOWHggnhXXxbh+jxJKv
         GsYlsH8p9x19q1UbaM5dGls6QIh6oPN4VxIHi5oaWFLjNWT36tmas8ldkKk1QWJCDchk
         mhd5poi31lCj5+HerpawCGCw2q9gXAlJkoeLj00gKXlzMiPcUerW8zSX4zLZ8Cyx9u4y
         aa2fWEsWOuab/ycf4es3TdbmU3vhUe+bxgVwmy6dxdxAiFpnlbNhC+Q5BaScKyOROg0N
         YgAVSlquRdoSsGOaNrJ3/qKFJPDfdjuj/sDfGiqiqFEPVYkPt2fKjtSlbuXIiHF50/Ph
         o/DA==
X-Forwarded-Encrypted: i=1; AHgh+RpCocZ5rKf+7NlkajdLFt9V1WvNmk8MflldxdjIzMyorgcoakAyj260QAgr9Fw4+uv497WICgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2P1J9UJLv3Ur7VyQCIVogtS5qnwg3Kec7XRCybD94i3LP7VU0
	3k+uPqOYUHosMHgvOUyBzLDt1fPjSYole+x8vNpIe3qbnOLNSGw0vzxO
X-Gm-Gg: AfdE7cnOf1xQn0s73H0J5Lqvp9us+na+Du846+ndJqjlo6TziZJ76AbECvxhr1gV2tx
	J4GQC1YMd76hI3N2O73aF/H7LPISyGukMa7CIJshN+eHEsbHBYz1bTPcX9wpXqGX3iFDlxoCguO
	1b0B8xOPhnVjTgjoEpY8AtES2ShnRl9n+b/42D4MlOCy9VujnJ5h+v68N+2rbmDM99/gbKKTXh5
	9hZyp5z8XSiWod83HqCyQj3kIlco7QJv/tlcDjYtdyLJ8Jx/Zn/TjK7/ne5WkLUyrYJQrlnmfcE
	Nz4r3PrHN6kdY4VkLvQ2CGZV40jI/pc3muoOhdoJ885z1UEBLdvhqdZ8Ct9ax3DUgRfTD6qfZ8n
	xNJC6m0FxgwTntTSdjfxWrZkihh+py4gQYxUbSa9snlpq+sGqVMGfz6CmDeXU/LWlAlBIVYkUtf
	144h+EqIeHyjjHeU5VjjUE1bXvSNOURZ6L4f7HLDguzw==
X-Received: by 2002:a0c:f119:0:b0:8e5:8d7b:5188 with SMTP id 6a1803df08f44-902351409fbmr120041846d6.9.1783905766785;
        Sun, 12 Jul 2026 18:22:46 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cad3csm117151996d6.48.2026.07.12.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 18:22:46 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net] nfc: llcp: Fix raw socket local ref leak on rebind
Date: Sun, 12 Jul 2026 21:21:11 -0400
Message-ID: <20260713012111.4066423-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raw LLCP sockets own the reference returned by nfc_llcp_find_local().
When the bound NFC device is unregistered, nfc_llcp_socket_release()
sets raw sockets back to LLCP_CLOSED. It also unlinks them from
local->raw_sockets, but leaves llcp_sock->local pointing at that local.

A subsequent successful bind on the same socket gets a new local reference
and overwrites llcp_sock->local. The old local reference is then lost, and
the final socket release only drops the new local.

Drop any stale local reference after the new target local has been found,
but before overwriting llcp_sock->local. This keeps failed bind attempts
from changing the old reference while preventing a successful rebind from
leaking it.

Fixes: e6a3a4bb856a ("NFC: llcp: Clean raw sockets from nfc_llcp_socket_release")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 net/nfc/llcp_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index feab29fc6..0c00cdaab 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -152,6 +152,7 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unsized *addr
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
 	struct nfc_llcp_local *local;
+	struct nfc_llcp_local *old_local;
 	struct nfc_dev *dev;
 	struct sockaddr_nfc_llcp llcp_addr;
 	int len, ret = 0;
@@ -185,6 +186,11 @@ static int llcp_raw_sock_bind(struct socket *sock, struct sockaddr_unsized *addr
 		goto put_dev;
 	}
 
+	old_local = llcp_sock->local;
+	llcp_sock->local = NULL;
+	llcp_sock->dev = NULL;
+	nfc_llcp_local_put(old_local);
+
 	llcp_sock->dev = dev;
 	llcp_sock->local = local;
 	llcp_sock->nfc_protocol = llcp_addr.nfc_protocol;
-- 
2.43.0

