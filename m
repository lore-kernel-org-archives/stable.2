Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967266;
	b=eeAQ1YJyVYfiZ1xp+k9YXivTHeTxI/YyDdNcQ2un/QA67TPEckz7FC304YJ3TVk8v/gN
	 ks+yRv9BpJBQ6vAfC0sKqQAH0JWT0tFdFGvw6DAvCRwOsF/iL0Eu53a9gSxuloOgdKgUx
	 PEqRqZoMm+76Mu93iESIzXqiX+1/K5sOJ6nu4WmmGLikRh3U1BIUj2Sco5OWqK/A7vPL3
	 6KNvtIEPXBQT7mlnsSBQDTr2pnZhZNLKvN2aBdWXOs/FqMVWxxPUHPL16C+WKwZ6uGLOg
	 KOYcBLdzUwFSLMT91NCAZwtK1/NL6uaZMpfhIGQcO4kHb2d7j7sccbkv5BuPdk447yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
	b=peVzdf2gU2wjMKx+UnnWbqBAeVRUBR8/BNTgMB8GZqQBITPqYjHuhxua1DvXNaFroaVj
	 iOpgr9L8cJGDnXLKNPKfIYrXWRkNo2bmUN7+fUcDS0xqQGSZMvWeDTvtFuTWofArYw6lw
	 SN+teljH/CSTfkVhJU+l1j1CYKSCxlRkIaKpQqQWQzlU4STHb+c5qfLWNW1AhQSitgGic
	 cKypnf6tB8ZPdRo5IUAzCF/Hhkc+G7IRjRBvqoDyM1vFipO9fIXJvb7l+qGbqS3q2mkYD
	 5DduIjutf/Xaxbn0ZXSOs3NEa4/5Q47CJMYpH2cw1svkPebIahLgWVPgbEg8tAeQBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a4JU4jom;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BCC606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 22:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85BCC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a4JU4jom
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so14988025e9.1
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967265; x=1793572065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=a4JU4jomKA60PUj7LOJEy/pmftUjnoLJg/Wg0eRB2TZL21uAafWunkF0EpPI7jtX7w
         ZLUmHBJMdrtAp4mX0pXfmjBP9UI5oHNY4NNXdI8DIEprXaD5kIslOItR+lV7EYAc7Jj5
         2Pf/UtjXIFyvNbDA53BrD5GlXNk2No/dxodNYHBYbgCX+b2x75CzWD7mjjGKaIqhXcdx
         Hb6V8HK2ujH2wRlS9IPdsfPOm6qFIkf/jetRiB+55S6tCxt/yLa2+fqtteIrBr43jIZg
         kOsw1IbNiyU0pnHY0zXyJk7F12TZ2ZpRzMJo36vVMedf/8AUufUblKQcSsZQ0ccpCF05
         u3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967265; x=1793572065;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=jfn0qKZG/FDjD5xa8TmfD77+lUePj+z+VrVB7lvty3j+vBhn3PjOi2/cME/zlGv/od
         7+8PEkT02G2D9zhJPMWxP5T532ySuFtxyiTaxj0goj5706nOlRxOHN6gCe9fLmWiEV3O
         n04fWlM/IZBEQLxcuBWjFzH5W8QJxmMIjGQCS4taOFxtBUsdC7Ss23i8i29IMTif9ECW
         3Io3mMhykLgrr6eUws4+pKqpdNnFfwvCk+NC+Z0ukwA3YDlYZAH63hLnJhR/GjvrIyrP
         VGvLiPQcYf1MWG5qpdT5GbGrvw187J3dvFDEiPM6Ye5dJePgLZZjwUtGKwQSk4KBxjH8
         0rnA==
X-Forwarded-Encrypted: i=1; AKwUvBz8mCo53P/dbJxTSu8A1OAZLzlZipw2AqQIUj/e3mpqK1DRgzy5qNB6PDBJ0QmyTKcvNskJ6P4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7PUB+D80So8jWp756xSwsjWBPQeysyPlr9kctosGgwzW4895l
	6ZntAAeaXBNhpAmAR/ue71HNsvqCgz48mmdi5z1WF8vPjHNkD7d8wq8=
X-Gm-Gg: AYBFou1NwaQ83U34Y9ko+DrP5k9xP7luQaK7/5Wjr4AsBO2HO08YXv4PNIkFbZioyDW
	zWMhamYxFbUk0sitv+Eybcaa1lDA5AsgCt+PLiGMcWQGSmOT6US8ej8TWgr3begwgQWzPYAJF/Q
	XXkU/nYYqK49Kp9rH2LslgHlA5dtqn9BNMUc5YmvyHfbpiJcxgnkKk3j0eGwebWhm8jtvKhkPFE
	3epIzyZPbUk8ida4udFqMYh/XqmB3f+U2Sf17+cjGYMDE599VJyHWcQT+aZGIiIfYEqE7sdA7D/
	Kmq+TwCl78VDXzdsg+pFrFATn8i5R5PfzRmFvcHwXIkd9ChW7RiFQKEoZbjNbuMBtBtqbUC4PiL
	N3yruqPvmCIUGjIHwYgdrqM7vq8297iZLHgSwJSa1oE0k+YE5+bISXuBy10900CoFnTXssWahKN
	0AjZiR1+6Lj6ZNSQThZynXg9uP1IWTLHgWtR843CX8aYVXhCnE4YW0AqRRbAz+6P0b+VTCWIOjq
	+qCzyRmOlWYYDalJc9fKUJqC5fvefJzrFSvwg==
X-Received: by 2002:a05:600c:a45:b0:4a1:e11f:b2e1 with SMTP id 5b1f17b1804b1-4a35aca4bbbmr98354425e9.15.1792967264894;
        Sun, 25 Oct 2026 15:27:44 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm401391845e9.1.2026.10.25.15.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:27:44 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linville@tuxdriver.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Sun, 25 Oct 2026 22:27:43 +0000
Message-ID: <20261025222743.1092003-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278531637.3327.11947058101101849130@kernel.org>
References: <179278531637.3327.11947058101101849130@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing timer lifecycle
patterns in the NFC LLCP subsystem.  The issue is theoretical --
found by reading the source, not triggered in production.
