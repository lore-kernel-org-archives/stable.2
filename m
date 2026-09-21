Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9273ED5DA
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004132; cv=none; b=mZXcP8YDfNuI4/j4NIl+MMw26czWwFFFHAO3Estv9z2d5d7eUJuoBtcTNO+Ap/Ak5lzv90aU6O14C34FGSAKNUCMCK3zDObRF55EQuf6MfYt5KRSE0U4nR08x6L9VH6ctkNucesvfbWeYwMFAnxJQ/ZFL1U+OjG0rsl3o1CT8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004132; c=relaxed/simple;
	bh=aYD4nV9Wj797N5jj1Ny6OHeo10YNZu5Q6nXuUfYTHdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwnFoMlAGXWVZuBlKWMaVxLjVf7fE7a//KZo0MJJKiKzxjosKnpsmpwaujLGqpAFb5YMHpo8halZengQmEFuedUKxUFJj0ZX3MkynmJLQCLPi53Dd0Laz0mRurIQgJ4SwPMZ/dcOeoWc/vynnJjvomTotFEHx26J4ZubIE3avgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6xgDeQr; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6xgDeQr"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-7f4f0d37f93so2178684a34.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004130; x=1790608930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SI73avUfus8pqTPOHeH7viJKyMI8CsxokGnHNJh0Wgw=;
        b=C6xgDeQr80LhdaFW7J8j2h64gvFSzAZznJPVjnZqyyZeDh5rM14PdUKt/bJhqP6M8e
         Rt+PwfRQy1R/Y7EiR7LChiD2Yy4FeEfYKg2pXq13+UN9u7FHKNwxPOuCVTzTxkRA2nhc
         fAWzIaf77bewHSVy5U7clQtWjJgYeVhoQLOszBZGhJvHtyXF+zh9HAXuS512o3qjILoO
         FLjimCZgWCBSbt3XUlmP8jHTBnBKMEY79WfyQe4gJxGv58ZKDMwOlcXDFlUpNCkZKHF9
         91o5XpoR9M+4waECoA5/Ob29rlL8mlr9bH+mvl0d/Ww+JhjEC2mP1tmYEhQwNHrZJYJf
         7fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004130; x=1790608930;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SI73avUfus8pqTPOHeH7viJKyMI8CsxokGnHNJh0Wgw=;
        b=LiU8Z6+o/ze/GBMTJJpz0yzm+vZnSGB8jktKjAEFxCChxT1JpnIWBbLOI9l70GdjPL
         Gdi41I+tkol8fyKGwfdgX7btt1YAF68VsroCMvvGDjBot/mGdYHD+0R8X8LfILQl+i43
         tmP4IgEzfpyKKQq+9mpRnaHm4J5UgaKLssG8AXW84uoHID3NiKpTiKGXlwYvhkTFsad3
         YeuiJ14MbSbVoPkaomhuneFdOFOydzWwTDyxLF3edhfMgUZZ4Qna3Qc7nzjoe0AHLzlv
         u4FhRLwOv7eQZDUgs5RNLVyOaBjmfhidL9vY8hLmZmA7/xYMfHT+sT4+fQgQ3gYond9Z
         FF/g==
X-Forwarded-Encrypted: i=1; AKwUvByLPn7TZY467v4KAMWVFT5QNkfAS+S4Yb7pHe/tVBhZ0HcY/3tGZtVcTXdQS8EjkHjxTm5UgTU=@vger.kernel.org
X-Gm-Message-State: AFuF++kwubai56JJ6FJYRMCC7juejokZVxSLHhdaai4jDwiZq8VoDx3H
	IWStkvgs5rK25IMFfcCOCOHOZt11zLR4Z08Kg5Xu34okBBWM9ovohKZJ
X-Gm-Gg: AYBFou0AhsuCWB1LxED6Yq64aQVcmaHMvkuK+Y6cGeUTaeA51yYN6DYowHXE7lOK12d
	0TpItfsdDChjseUZ/dDAvlhRS8GnRUhmGaJwVP2WhxTN5/stMEDw+XFtMsgEdn2105KbvHKTIih
	nWEaFY8ZDuoiZLOCK2U+gzoKwrz30uNUbh0KYe0PW7ditiqJZHNEG3/h1SvVgcsACvouBh8QigJ
	J1Q8PfxVyaokLdCelfH7+5CBVANvHml0uOB6/5w79o5DEqReq8kPAI7IsmvDzBiiBe0nEM+4mek
	kgHIfrsH0gVVcjafz5RFavvJ+J8ykkg+bQG4uBtTLZi/GGEAB7KA7c59k/7alYI4gFnSI0gyf9w
	/TuWWM8MTFBIjEdziqfkbbSjrQWgKVXxkU4zPfhWp+JkMdHKktkjgfNhG31WwWuCnR0WvlwkNIn
	HGTMf3e3vWr1721JpKPyEAsE7F67LtLMLldSb+59+JMhAx0qFi/HVOUGKCPENmf/I=
X-Received: by 2002:a05:6820:c8e:b0:6b7:46fc:1db with SMTP id 006d021491bc7-6ca9d5540e1mr9509282eaf.58.1790004129624;
        Mon, 21 Sep 2026 08:22:09 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d1476b906asm185690eaf.14.2026.09.21.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:22:08 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: konishi.ryusuke@gmail.com
Cc: dubeyko@comp.asu.ru,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] nilfs2: fix checkpoint root lifetime on sysfs errors
Date: Mon, 21 Sep 2026 12:19:38 -0300
Message-ID: <20260921152144.3983736-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKFNMonYVUbzjYm343Aw-=xjUk78x4EdUwGBfNRwE6zfmRVhvA@mail.gmail.com>
References: <CAKFNMonYVUbzjYm343Aw-=xjUk78x4EdUwGBfNRwE6zfmRVhvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In-Reply-To: <CAKFNMonYVUbzjYm343Aw-=xjUk78x4EdUwGBfNRwE6zfmRVhvA@mail.gmail.com>



Hi Ryusuke,

Completely agree — that is cleaner.  v4 (below) does exactly this:

  nilfs_sysfs_create_snapshot_group():
    error path does kobject_put() + wait_for_completion()
    
  nilfs_sysfs_delete_snapshot_group():
    kobject_put() + wait_for_completion()
    
So nilfs_find_or_create_root() and nilfs_put_root() just call the
helpers and kfree(); they never touch the completion directly.

v4 also keeps ns_cptree_lock as a spinlock and creates the sysfs
group before taking the lock, per your earlier message.

Aldo
