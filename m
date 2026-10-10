Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA43C062A
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622219; cv=none; b=OGs6x4T4xazFM4+HD1roBGux7DZNzNtSOWKoq3UjNSYoqLt6FzNb3AwZsAC1qNtjt5+3Nig4iqKQeeBKEejxSaBV0hH2m4VBKk9EyvT8WpdDt7ZcWmS+Kv+ngMjvV1RwRH3f3Ezd47HiybakRwjkyBMoTQEun1Urm8PQiO5SsTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622219; c=relaxed/simple;
	bh=dBpu91GhGp71AhjQrBoWYb2hnyV7FaxIHcjPH1PEfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bccjjt8bDlYFJUycAWvtjEt2emqxGrnm1un4nRIIo/R4csVsEoVZpQ3E44d3H9KOXvu2odvdW58W7irzmAszENF7lsdqPVQT8IG4tbhh3aEe40KnebumK/Wn8CmfwJSBRFZVzTOAkzTvLidQpWyMVuEbLoruDXAmqFL9hDPJuHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8jzfYGa; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8jzfYGa"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6ddf6877d33so9523eaf.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791622217; x=1792227017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AzRHZlsZ/kgam4CoQL/YmVx0Bb+p0rC1CfcNC+r3us=;
        b=m8jzfYGamQk+j9hdrbtaz8f+MPQq+bfSmP3btpbh1BkppDnFb7EHmFYSrRK0gt9Kfg
         mZTD7gyiYLojvRCkOtLZmBJDfxB2fuaRAF+BzfMPtOXEbkZDYMpHcjRi0BBcMpHwqBhX
         UAjMiVKAO25slOYDvZYSr5JIk5/tUN/CSoZlVLWANNGKWNt57Ku26/WWpkSneVQzEYMA
         6ceBf4cnUjeKw8esDKzsqTdceAhDre7fRkWaZpJ4GqjvD+pNNF1YcNPxANRcCvBkYwN6
         u5vHb1qkITtHXFoQxdMqQXki/uPjKySE4MUVJ3LsfVFVrru0avn4+93G7C37aUQzHZ9k
         sY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791622217; x=1792227017;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0AzRHZlsZ/kgam4CoQL/YmVx0Bb+p0rC1CfcNC+r3us=;
        b=afaQOX21UD+eotMvdLa0z6NxxtisW5pAUiuQQGXPHOCWKQQ+gXTN91UNvERLB5hg37
         xSnc+KsvwgaLE5HN2GKZOW2/bX+cybk3UnCWQfmldW7ZPh0zIU/uXrx5+S432zWo+Mr2
         CKtKRa1c4lyh+C71RWwxhdr+uaGxHvywToroaHOG7laOveqc92//VdtibZFx81P+hRcq
         MuR697uQMDsT47S0B9K+/jh1WEKeu1WQKvi284HRI7qxMIF3lIPnROWhfDppSwMMvbGr
         4NxcDQPxxT8301ZuPDoUbGRfJbZjLFoXa4p6vM0cvidxplJbNSHdGz+S35V1de9OqsLk
         QfJg==
X-Forwarded-Encrypted: i=1; AKwUvBzV1/N8I7i0w8+C4ILOLM5QCNnFTpzBocvpPZyl/EsuuK2JbgJWYdcw/2IKKoJDH9ib8vd+SBY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhNiz2C1HEgMBC0JMZxnCZIH5idbKQkfa6o2u6dGQqSNXxhhOL
	pNwMBI1nDMf7EQQe8NmcSQuSJaMykME0wPprxMyu+hgHOqQ2hSmOcjHK
X-Gm-Gg: AYBFou27rtSqHw9GSBRl75EYSlXyP9Q4obdi1cewj4j7y49Fqh3rPDWzDNra0Q0kYLj
	axF8IcmrnDOD4Wm9Z6TP8XHcv7uttLVoJt1RJTTNVyMkDbBVUBK8AarLPvromliLQQIc86MxKwU
	geVmsyoEr+qJ4YSCvIioD9E/HTr5LkNn1xSH0GARGEYTScPKJnhcDX+iZtrV3t5fG4yPsoHEak9
	NofWxZk5gahjHGn9fOoQNBI3f/0rlVgrpcM6Kj2T9Z0coYOSRxSu0ny85omOpvgm4kGeUXDD73Q
	o7tiZLwPIm0HpDAwmJ+aBsO0J6ibumCfo7h8lJ3tpsTk9UjjWHhrQInIqf+kbYAwTZpG1X0phAa
	XT2EhdM85i+/Q+q2F9eAoAkIp+m6Dqv+q12Pv+ZUAbPEdNbWj4uOV89QGvcIBJVjt1i6v+GLNZf
	JVeQgW0kz7kWHAsSJ5BTMkJK/bxy1Fe6vxd8C7CmiZI7tbMbfjcs5jhBlZ1uHR0LheeKk6OCAPB
	Pk6sOotXFEx3MeUalIEjbpA2ID549tJhSA1lA==
X-Received: by 2002:a05:6820:4dec:b0:6d8:462d:2737 with SMTP id 006d021491bc7-6ef0e8dded8mr2517883eaf.27.1791622216750;
        Sat, 10 Oct 2026 01:50:16 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6eef6e22b46sm4037577eaf.0.2026.10.10.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:50:14 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] ipconfig: fix use-after-free of device list after ic_close_devs()
Date: Sat, 10 Oct 2026 16:49:58 +0800
Message-ID: <20261010085003.3261587-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ic_close_devs() kfree()s every ic_device node but leaves the static
ic_first_dev and ic_dev pointers dangling behind.  When a DHCP
negotiation gets an OFFER but never the matching ACK, ic_bootp_recv()
accepts the OFFER and records ic_dev = <list node>, the round times
out and ic_close_devs() frees the whole list — node included.  The
next failed retry round runs ic_close_devs() once more, evaluating

    selected_dev = ic_dev ? ic_dev->dev : NULL;

against the freed ic_device — an 8-byte use-after-free read.

KASAN confirms:

  BUG: KASAN: slab-use-after-free in ic_close_devs+0x214/0x220
  Read of size 8
    ic_close_devs    <- ip_auto_config
  Allocated by: ip_auto_config (ic_open_devs)
  Freed by:      ic_close_devs <- ip_auto_config

NULL both pointers after the free loop so retry rounds take the
clean empty-list path.

This memory-safety issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 46acf7bdbc72 ("Revert "net: ipv4: handle DSA enabled master network devices"")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
Changes in v2:
 - Fixes: tag corrected to the commit that introduced the ic_dev->dev
   dereference that makes this a UAF (46acf7bdbc72); in 2.6.12 ic_dev
   was a struct net_device * that was only compared, never dereferenced.
 - Code comment in ic_close_devs() dropped per review.
 - Message reduced to the memory-safety mechanism (no vulnerability
   framing).

 net/ipv4/ipconfig.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 1b8585404a41..ac4851e59c3b 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -346,6 +346,9 @@ static void __init ic_close_devs(void)
 		kfree(d);
 	}
 	rtnl_unlock();
+
+	ic_first_dev = NULL;
+	ic_dev = NULL;
 }

 /*
--
2.43.7

