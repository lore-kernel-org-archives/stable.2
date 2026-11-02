Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613186;
	b=XPN/f/rrYdcYqtKh9rShIh15VECtXTjyJjfw2r1hQSvKH2kY1mzE3jKpMOVbfW7SCOlm
	 QP4ko9ZT+KPQ4TA0QRFqxFBCSBBKsSkp/O1FuWv2w+TtXfEQnV4PIX+98lZ8iDVWrAC0C
	 5ht+pmQNpsUhgEzVV4TJNQn6lW9JoF1atfznHx9FC8T1xsRjWXMS+ZHpDmcdQcDWQTOGG
	 I6pX+oL9J6t+OVr1qyNPpz76Ejj8w5aTwVL9QPc/eWG97BfT7CJZFsOcqe2f+xNxqPW+x
	 2Hw0apNuFZxCqzHlf64jET36hEcpUclOeuLFH9wAFkj90vddWbjTph+L7SQDziSgpKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U4e/HCkTNylRsmi8X4W/UinfEijmoIExq4OMj38bBYY=;
	b=ZZgcJUpowIeJdyoC+j3f1YX5GnO8G4Gats7FzqJynJgPDPWNXi2s0AfXKNYNoemnWuQj
	 1PETGd5xKCl3MDKvypbYqVi/WtOKr4RU8bLxP17PfmMyBJzG/jD9QwgedUyKhde4hzO9b
	 LVws+OIcFB025SHhflfyaouFs5G5uK0fzpEQP4kFQPgUjaG2QXkTshTf+/0a8ztwsYov/
	 nB3nf5VLCidPL2tCdYJiZ+G7oTTCdL1639OTQO1rBwwgd9eCHBEAthnqmWZhGEObm06Ef
	 4ALzAKiOhw5B1B+bBcIUCUoyXGWlBel6RIuJqSJ34fYEWMNupy26to9yq/IxTfzX4Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S249brKC;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE7606A339
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 09:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEDE7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S249brKC
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2eb5251724bso4824565ad.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793613185; x=1794217985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4e/HCkTNylRsmi8X4W/UinfEijmoIExq4OMj38bBYY=;
        b=S249brKCPZgC3J8sQaLmT8ILKpyHUiEKilVRekXjW9umgNy+bewsg0WKRb1KodNbbk
         EOho3wj6a+C/szTvn1OU3AIMxrgZR8faiaZWLZ8VUdMBpOruNcavkkdIgCnSpWU4voM/
         as8/2eiXipcQ/mmMdz7cPKCFMpp7+fyMe8RtgDASuWr6CYMCj5vs+9Bn6rfSrcvR6zFT
         fM+NrocyRnUzSA5W3pr3cygl6OS/n/a1gL+ugQ7dM+FEi5fE49m1bC4QHUB7Akc4bCHb
         lgcVTvcxX1UUAEPLrL8+SUJNAEWiWSjfFBKzGKRhgpG62Ve3tVJ/CySUQ47UQpUAS2RB
         VbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613185; x=1794217985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4e/HCkTNylRsmi8X4W/UinfEijmoIExq4OMj38bBYY=;
        b=pdwtO+iyLq9aBjvxuN28ZJbPA7sisJeNWIIqg3P8lXEF+I8vmErKOPeDQlGP9v0HPf
         WST1bJCCBGcZ86pBoei9/yxmDmm3nJXLruxOyIs9j90A4L+HMcSFSiy4Dl+loL7m26UJ
         etzlXYTVL55obuZ1r6Kd+fNKeD/R7ZAkAjVGUo1x9BtRhbqD6nGw4eirWWSKvShnGtZV
         tQJQ2YYrf1ah0He6ksaqMw/5pCHTQafFJqYS9CT8H65tRRXCBhxgsJm5lgmrVVJY/YSs
         7zJm0CPXG+iNrgVaIkHLajiJs20tg+OfrM2JnoXWwXl/FD0c7kyZgBDgJ+3gFRgzXgly
         NnSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIAS3D0z2dwwUPSp/vEBmLmQ983fglnls/U7hCSbMTGBNUPTbQHc4QiU/cEfbaf5xsdVUfwRk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8arCn4j2oh/A660hgxNJhXCYTgQvQ1B5LS0hsAbp3iYAUwlC4F
	PuIcwfERecxM8e9tHbq2Wg3QB0SsKgFedmxkRLs6dNQWiJOF1JJW7LlH
X-Gm-Gg: AYBFou34EN5K6v5c6Fz1uuEzVoxNdwEPdxuciXg6dAyjeiVXzE9N51Xdo/daY2agCZd
	sqLCR9pZV1WtJZe8qIvJ31vOsw20yO6HCEpQ33bcRgksRIsu27oDSrk7jYwHw0E1LYsSgVwQFhH
	ZylzYg4ztv/vWhsB4yUBk2BgWY/4niK/UTMMirY0+QCdIUgMbiuvmdWpyDJNvWVXOxWJ3zBeAs/
	EEkvlDSVmevRH5aNxL8fN+hFpN5a3Ph9sHSYdhadm+HOVGKFPRnbWMIVn8EeQcBAAkT/pDCrshH
	91+JC15fy8PtlkXubpBx7S0sKVRYONB+oAABGFG3TB6BGRbqoc8mPLbdpa5RLEcVb6EJe53etJI
	kX2EX9DxHyQPm4l1vIf6KkFSgZT6xgNlEm9duiWThZkZWKhWnEF/edVp9T4sf1WGiKOzxyJh5XE
	rtzQEuxWszDjwLGicIa+/XrVNiMiyRAQ+iBM6U79+IV3x6feM0B5oPUCkFL1QdWrqFJ8t3JtWVU
	6s6ltxXs9ikA5+jNnc+cCZDklOI8wjcHqcDL/DjFVfAsmImKQqctM77tZ59QzwtMFxxueXvSKho
	Nebhs9sG3zPdoWd4cBywQJLQp7DK+w1pcRcUr6jbiMZYN0HbN01y8mw=
X-Received: by 2002:a17:903:18a:b0:2e9:9a19:c5b with SMTP id d9443c01a7336-2eb364de913mr93536715ad.47.1793613185064;
        Mon, 02 Nov 2026 01:53:05 -0800 (PST)
Received: from localhost.localdomain ([155.69.168.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922fc4bsm26472485ad.12.2026.11.02.01.53.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 01:53:04 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: john.garry@linux.dev,
	nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Do not drop the cdev reference twice when cdev_device_add() fails
Date: Mon,  2 Nov 2026 17:52:57 +0800
Message-ID: <20261102095257.37287-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261102095015.36448-1-izaiahsun@gmail.com>
References: <20261102095015.36448-1-izaiahsun@gmail.com>
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

I sent this without my sign-off, sorry:

Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>

I can resend it with the tag in place if that is easier.
