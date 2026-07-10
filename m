Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0172449992
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691292; cv=none; b=uFjJRWiSB3OgdK+77PgRHKN59WQdZo5J/LyiJ74Rl5RKMGqP12rZzNfQb7BvSW9KG7Koed3QQW7BeAr/Jhzba3PKg+FGt4HhD9QyqNNrTSAXOvH2B1rni4KOA7tUowFrag2AhGprBow7Xr26+uumgAcVeVxt/tqR5A7eyb/9eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691292; c=relaxed/simple;
	bh=ds+WsdpEi7oZyHbjA8JLco4Gx8semttP+OHBdfchtuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idOjrjlEoUYjeUMmh61ac5eFeu9OsMpx7/bSYPE5r+Mg+rYG3PM+vSPtYEjcXPUA3Lbw9K+hTHUjtS1o2t1YD3Gdmdi9Zd6elxOP18+w6Ng4RsNYNoSOmirFRnr2joQlUSqJQ/Y3x1pBwexA9LlW5nR5cF/kQoJC2l/IPx468mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7+6ZJhU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7+6ZJhU"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso486517a12.0
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783691290; x=1784296090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ds+WsdpEi7oZyHbjA8JLco4Gx8semttP+OHBdfchtuo=;
        b=P7+6ZJhUAyFl/eL93ysieNKvVAVUVo7ZIzXsuTTXNmjIVmIgvqzQyy9zAQlJMyBVKT
         U+Q1RrpQc2CcITCyDB5XwBUiFf6TYIqIzYsacAzhaDFwvJfo1m1QTGS4L6nchdXu0FWi
         3BR/sXwFiMnv06pVanQTZUiwu6FxXrS6YfVUTYXuu57EQB1M169NNQ5GgaIBCFJKThUe
         JmOj8P3PxUwJZ6gpuGmBHr3O1ZSB5+AGjzTi0leGWcOkeVtgVUCXwDPH3Z+gj64ehl7j
         LKUYDHkzdN02UjdL23DdXlvqsXpqsAKwR4Q53aEmilDWqkNS1yIpugi7BGO/UZ6YNvwY
         kKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783691290; x=1784296090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ds+WsdpEi7oZyHbjA8JLco4Gx8semttP+OHBdfchtuo=;
        b=KJ1pgldoh8VmbNxBEHMOs3llPoVL0JRw5Mgev73AYloL6FHuFM7wRigKPgvJkEHpZ4
         aTSWSvOqEaBLRncWuhdSGAIeCNBll1I+zcpFG2HdwbOInWpGVCNoi0u8A0NOdtbhajAQ
         mcwh6JxoPAIriHguYDhXSUCB1xpJ/OE0rnnG2w6jV2juT5QGSXet7gYGZBMlk8yU4iuz
         oZ4ezuZWdsgPHRetAzpJ0N1yJFV1S4SLCWsh8R0E3Ke3h4w0uGxcWglJ5UWG6Yd92SVU
         TS+77AKpw0JDVmMx7bVU/EOX/zJQxssH0JKHWSaJYHu9H4rhejpvQOGP4ssGj/yFO1kv
         bTdw==
X-Forwarded-Encrypted: i=1; AHgh+Rq6S5d7CBoKiYwafrgyjU02nsBWGB0zYNLI+BXPNGTOBTVG+XbuSvT7yWsZ4gjbFQScBEKRmAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJ3YEqHjBFn9RTpWGi8hzIh7GkeMgAkKYbjvVRldLkUlTxQAb
	gPkC57eN1P6sCs88PUakvpv2O2KHQwJudt6vHTX6vRjdsQGdYxD4CC/uJY+8QO8v
X-Gm-Gg: AfdE7cl99aw9mi3C1H/QQtKI6LD/HPZlZTCoJwdqejC1SASvFfl3vLBuR6dnygTAgEP
	+vfTb2BFxmrwn79N3SR3Iga2afXSs8CRLXWJM+9QSG1anKbgxsfJtFrGhkWiwpI86fbrKyNsCfK
	Qh0zRCYB8oTZBli2Odx6jtokd7nN/sxAceRqe4xuwzbOyJfBXVokvHFp/7eTTtNM+xL9ZpRY58v
	1LuWhwVjYbqBdDBGPZ/yc7aoGYRvdvri++throNltWs5ZmOc6lLFBh23zzo3OG7azj1gN5JMBN4
	1RvrbaXfVWOY0rxxvIYrlRynbK1lJbFODcqL7gjlmua3qtLiNrVeP+MRx/9tfBF437sgZCyUGuw
	Wy745BEDqH95QoCUSWzI6Ow9kRDIEPvCZacQzZQNDgC1TYvqLrvyvmWuPTpdwBW4LzTMsjRV+WG
	M9Ax61/6GMKWyn2Mx5IPRT4A6jlfWo9Rq3/ir3K56Lmsz70Fh3tZVAM6QQcPeHGA==
X-Received: by 2002:a05:6a20:d708:b0:3bf:6c04:a813 with SMTP id adf61e73a8af0-3c0bd1595c4mr14595018637.52.1783691290090;
        Fri, 10 Jul 2026 06:48:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:5177:5cae:28a4:5419:ac62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659666e7sm48830449c88.7.2026.07.10.06.48.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 06:48:09 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@samba.org>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] smb: common: fix undefined shifts in LZ77 flag encoding
Date: Fri, 10 Jul 2026 19:33:02 +0545
Message-ID: <20260710134802.43909-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260709173019.36808-1-acharyalaxman8848@gmail.com>
References: <20260709173019.36808-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Enzo,

Thanks for the clarification.

My concern was that the current tree does not appear to enforce that
constraint yet, so the code can still be built in 32-bit configurations
and hit the 32-bit shift case. If the preferred fix is to make the
64-bit/little-endian requirement explicit at build time, I'm happy to
defer to that direction.

Regards,
Laxman
