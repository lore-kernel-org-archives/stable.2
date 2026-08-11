Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5D388E69
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488684; cv=none; b=ptTFztQ42BuJ5S5jmyBZaf4JMeRNl5Y23KoZGmrqM7DF5rEXPj8NFbJOBa3/suDSWLUvuf+ncF3FWdFQIZDsOSqj69+zMwvL2WC6QCD8CMXIIvgLO/8iRIUjK5WJjsY5S5VXvqh9d15pfJ/dZyXn6JbQ+DNStHC4PMOsw2Q0Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488684; c=relaxed/simple;
	bh=vYfhyC4OO8mWaELc8/W/kMF7s3rYjL4xxMKBsGrsZMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qigxWpQfvdF8Wsua6HbwIKkZXqfZ9DJNp+BjzJtqQR+MTHBFJx+wvYgWyTZTAqjlPwBBa91FlHQOmFii3IGmnVrXKS1awbNXdgWE0JRan0pAZ/s9n23L3gBkLeXQx7OfLfxrSFbEq7tnp1vl/Niy27ccYlYdQgKk7RVrPGnGZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFKIKtuR; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFKIKtuR"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b04c0b9159so229660eaf.3
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 15:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786488682; x=1787093482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULj5VW1UWlM8YYUcQzLWByRAMMT/RaKzn22tl/DU+7o=;
        b=cFKIKtuRgRqtRtu7ZxPn9wGTnRfs1bc+b81uHLAGmXwuivC5Iq/QqnltiBJodle3rj
         WFDIW+EAdKsPOJaypQ2w9PSCRATav+5jTLgQHN+Lbx08Dbew535PPVMSniojXNVY+Q48
         LRQ97vJgpeTPEjARmOxWFqCoZHShEGYxvd9kZKuu9m6XnxZpcqLMbcHLYyY9KPQFBskM
         38Ct44u7Jmn2blEv4A7ZH9dtsEXo8eJ+k0Vt3BFhNdByYKIRP6cWwKkJunSr6pfVTO0w
         ljtMeDDf3yE3lD34KXxfWhTuvZwPBUqpDuardQvLdgzgHOfkANk73jApakogRqAbN0Nd
         e/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786488682; x=1787093482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULj5VW1UWlM8YYUcQzLWByRAMMT/RaKzn22tl/DU+7o=;
        b=dNlhZBH0mQ3MVw0dJdjgYa9/81vnqWOY+pPcI3AX044CaSYgbbICxiVBxG+3O4CjQF
         mFZOqIRu1+znKJhtZqlRPmtuUUSUFGSoEygjzfvaTUUs7xxa3Xd6mVWTDPL06yVAKQfT
         bKpVtdvG3Mu6JY0LWQM3ncWQqmKVlnI97JeIBlvEMP6CbinoZScyR8KmQlEI6YiEXPUP
         qqkbksmACXEDD2D1Mg16OU8mUE8+eHiU+kYTQiXCJ4Qi7e/JLeBDR18AppzGG+aKFyGh
         CZBZxl99Im3AipUKAzOoplh4fd5PzE+dcOwuxc0TjCxuP3xBjUzb5VYwPd4hzLKGy32D
         jnsw==
X-Forwarded-Encrypted: i=1; AHgh+RoP7DIH1sYdAkZaSyOZz6Ha9GzdWDX8G6cRzCq/3x87BlVWcj3JnpBxvY5+p8wYbna7+hmp0yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7vO6CfxkKW/J16DmYtRcx8Vn4cstQm9AjIEJLv9yiI6Vj5zn
	+NlIagkIGXHfFoHZ2bsiHjdjCTFOB6wubJx5CvN07rOmRMe+ymQodnGu
X-Gm-Gg: AR+sD12hlQRPs2QDpU1EcJCGnrWzJUshZkvc6V7QbLo8DsttyquowtBrCQ4MPRREK3w
	Hb3XQWzp5zLeE75O+0+SQc7vcsbHE59+RumKjGyaCPRhkTHEivu2GWuj/GtMbwSq7/Nmo1BOZXG
	cHYKoQq43e672ybm9axcTDHKM4/FcGR4TU7BFiyZR6pWFUf2nTAWhGFDOTC6++Mbqe/G9R+KRAv
	etVdPf30bTt3V0cJk/wFc53GsKfjf34ZtpI+EgsWBAddD6eG/LC3ojPoA4yFcCfeTu2/xORS0cU
	hYrew8D9vuebaThURkTym2uE4msXdojHlaBbAc6yXX/FrTcdMjL4JNN8+FwjwGqi93uPR3qLv2o
	Jg39k6g7N1pNzoS4bXecd0wTA++AjPWZm3y0P4l/VP6hEhBZazj+K7LWd2dWv6XJf1cBbUfg41O
	/bM0nVKnleUjI1Omcir1appJxUwWAl+daPZpMYJ+mUJhLNS+ZJQHTCXKHmmiR0rVrWJLRHZ9DGl
	5SaJ+n7i1XYayOjtvWFGUl0EmRPXaq+D478YkR+QUw=
X-Received: by 2002:a05:6820:3088:b0:6ac:a8ef:9a86 with SMTP id 006d021491bc7-6b0b2673790mr405371eaf.15.1786488680805;
        Tue, 11 Aug 2026 15:51:20 -0700 (PDT)
Received: from LAPTOP-DPAKMOI4.it.purdue.edu (pal-210-106-74.itap.purdue.edu. [128.210.106.74])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3475bf1sm1019766a34.26.2026.08.11.15.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 15:51:20 -0700 (PDT)
From: Yifei Gao <gyf161023@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abelvesa@kernel.org>,
	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Yifei Gao <gyf161023@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
Date: Tue, 11 Aug 2026 22:51:01 +0000
Message-ID: <20260811225102.1077841-1-gyf161023@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806235056.456341-1-gyf161023@gmail.com>
References: <20260806235056.456341-1-gyf161023@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map->table is assigned right after dma_buf_map_attachment_unlocked()
succeeds. The two failure checks that follow, the len > map->size test
and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
jump to map_err with map->table already set.

map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
through to fastrpc_map_put(). Since that change the error path tail is
fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
unmaps, detaches and puts the dma-buf whenever map->table is set.
The two operations therefore run twice: the second dma_buf_put() drops an
extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
dereferences the map->attach already freed by the manual dma_buf_detach().
kref_init() sets the refcount to 1 with no intervening get, so the final
fastrpc_map_put() frees the map synchronously and the redundant cleanup is
deterministic.

The len > map->size branch is reachable by an unprivileged process via
FASTRPC_IOCTL_MEM_MAP with an fd whose dma-buf is smaller than the
requested length, before any DSP invocation.

Route both map->table-is-set failure branches to get_err instead of
map_err, so fastrpc_free_map() is the single owner of the
unmap/detach/put sequence. map_err is retained for the
dma_buf_map_attachment_unlocked() failure, which is reached with
map->table still NULL and an attachment that fastrpc_free_map() will not
clean up, so its dma_buf_detach()/dma_buf_put() must still run manually.

Fixes: 334f1a1cbe03 ("misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Yifei Gao <gyf161023@gmail.com>
---
v2:
 - Instead of clearing map->table, route the map->table-is-set failure
   paths (len > map->size and the qcom_scm_assign_mem() failure) to
   get_err so fastrpc_free_map() is the single owner of the
   unmap/detach/put sequence. The map_err label is kept for the
   dma_buf_map_attachment_unlocked() failure, where map->table is still
   NULL. Suggested by Dmitry Baryshkov.

 drivers/misc/fastrpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index eb6c2a78d3c7..d480a87752a7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -881,7 +881,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
 				len, map->size);
 		err = -EINVAL;
-		goto map_err;
+		goto get_err;
 	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
@@ -904,7 +904,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 			dev_err(sess->dev,
 				"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
 				&map->dma_addr, map->len, err);
-			goto map_err;
+			goto get_err;
 		}
 	}
 	spin_lock(&fl->lock);
-- 
2.43.0

