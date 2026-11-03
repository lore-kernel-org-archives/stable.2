Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688105;
	b=phft56wqRq0PNaFRkKNFDJgKwz5ww4/F/ngviiPQKX77+bIaTbc5ycwEYPvTRMG1Mt9P
	 NI2VKac4QAiE8w4je3WHPU6BaBMG3sgdiSQ4vEsw8k2Rkutct0f/WU4XUuqWVbtb0rIrc
	 jorratT1VyeuSah56o5uXdYkg65/NsoHa/HWAMsM2ZtIv4D/irvUgdf28LUyMXAjU+FBW
	 u4oI1BP5nzUs+OVDQ3cvEFnTlTGcS1g9yf51VyUio1Qet2DHvXjUY4zPseqD1SBRFb4ZL
	 HWTaLytsrY7XG4A5i6FW97MJkbHZTNeluMxe33mKnS5PE671iAnn3eWKB0xvQDLQ/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3GhAdV6YWwOILn4mDd4q6cYiLjqazm9wTfpjdpaNwRQ=;
	b=2t89ln1QNIKa22D7Aqml3DMgG3X0Gn+WwZNAS3aC+YKR07S6/2UAmOJFdj0cwo+81V82
	 /yZvg+IG+e+k52NgNW8xQKyypByFDPenadvfqejVvtSpBFZKVtASFqJwTNBr/Hg47BmzS
	 fdxq5hv+W+AKbY9Ttjy6rVMS3JnGZOthCDHOWYbD8V0aAWjQEli7fCyq0/KfI28BJM8eJ
	 dFf7CNDnF5Guz5XPkqw8J1kHRR4KZ+AsbFHMp4Eohh2hn1A4Je4LDaRLw8z+rivFyTaJQ
	 9vkSUrny5RnbdhZIVtSGhvm4iM4/e0WRsJ+B89yQQXkQM7Z3LpQLmabIrj34VWHBoCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=asu.edu;
	spf=pass smtp.mailfrom=asu.edu;
	dkim=pass header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=izsSScfq;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7F606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 06:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CF7F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=asu.edu header.i=@asu.edu header.a=rsa-sha256 header.s=google header.b=izsSScfq
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so6533434c88.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 22:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1793688104; x=1794292904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GhAdV6YWwOILn4mDd4q6cYiLjqazm9wTfpjdpaNwRQ=;
        b=izsSScfqtaEPi04OrrSMWvX3ry3jlF7A9LPcriwbQpO/4rWhTeZT4pB18nVqdcWZ/E
         AjmrJdC4nUFacz/Vcx2JmSsE9Biu4lGwoy+cZP56fPZxJ9EeyCFhRJKnUwplxJ88rc7Q
         uCDthukfC0wtFudfwjj7b8NuB2EU7wlH7HLHI79kH+lsTzNR+dcIIt5z8n25uZuAaWmB
         hfUPPuay236DgiT+/VtDPz7y/wMHliQhdyoJzdIA6dARpaU7jDLVIKY6BD+wde3CddFo
         qL+J7Ddc2MktG8zns4ZSgBHI74CDl+Fwfwyv3IC52UDajptlFsnAZOCxXtUPZw4P8E3t
         DCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793688104; x=1794292904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3GhAdV6YWwOILn4mDd4q6cYiLjqazm9wTfpjdpaNwRQ=;
        b=t/FG73QPd9fSOmU5v/861BT6W5qXiHaVXASUAk0QaQqxkRctpwtflx4Kovho6GyrC9
         B6YzTFChWARg44Ld5GVraNG+9/d9ghSq6FDiTRz5CTEI1ZFtohmxa6V6gJhFNMIfwmOj
         NI9svxelnjLRPtYl+YusNOD4wJEh+M0sBDBjZV2yhVkeqEGNPWnC54Luq4B+ABuz+n3I
         KH47Z1s8rEzb2Bmx8SNHNcSfiUTOwxghGol5QUU8yOWoLhrYPo6Dlct6AGzXUl3oSvdB
         0HXq1MhUAeWgs2B2U0Uv+uJ61BAbZYk8B/3jbAbpzBAK1PvBEpcd0BYvwQ513w/dg8fC
         hDlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFzjShsBb9ozs0O2o/k45MbAYgLqECvnRxbdIji86IlqRHeRWRyw8Yk0jSpfPGDAGAuc15V28=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UBD//zhWbnQNTh5Q2CIuydSkBRb6A50J0qNduMYoBTkjHsyuJ
	Jqt7aUwt3n3+biEtInynZKqE9nhDFHeTqz4/kgJvldykdWKmNktnNKTKItmNOZAyuw==
X-Gm-Gg: AYBFou2pJ/xSxedU9VCASnsT2llpifROysqiwGQM8Y2d19+eDlrZZVYG0kqHhIALXvE
	rjQT4r7S5XG6ga3lUK+S+omF/hnrhXeagzfX1R8I06d9NXNoV6qxfOoN/8jfoQuyQXg7SvzW8fG
	qUhJ3vjTQsL/ow/qS3W4hsFZ+jWCQVbCutT8z4Brt3NCdG3HB0/i1XoUthTX/VpyaV/9JlOM1E+
	p0sAQ3tZ8LgBTS6e2RWTxbtNWxkBnInc7jKtw1KSPlSIKgZwzGgSnQx5k47l/eDvPIVrqCdnYBi
	vOTWCb3F0tfCpbUb7M4LKE7SAtnmWQNg3AmlrFFREXPiPsLDUsyei9tIH8VkT4LgQa09flxTnYV
	JlEeJWtg+zjEztFTF2NilcRIekp+v1YR+EqULbQjp+Mki4fOfFvgh5+8YqsEVUZ485EC5391Vlu
	KJyslFsY1W3VHB0aR1CmiC0wb7dbl8UJsbJXSBrVwVTJbc7hYXxA57q+BLT6bh9LV4LdUGcDLc3
	iCN7XX5OeBcHVbuSY16NP/g8k1UcAVsl6F7W/GSqRyMAo2K3LAosJcAIOgyzXHYpztdV2s7uT/i
	xrDcVizywdM8/0DwnpbLAnLmlIJK7OW3HzlL12YfyA==
X-Received: by 2002:a05:701b:2311:b0:189:d6bf:7ec7 with SMTP id a92af1059eb24-1ac5ae39462mr15976051c88.19.1793688103972;
        Mon, 02 Nov 2026 22:41:43 -0800 (PST)
Received: from localhost.localdomain ([2600:8800:1e00:25f0:10b:4313:ca58:9bc1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm38876730c88.14.2026.11.02.22.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:41:43 -0800 (PST)
From: Siddharth Mishra <smish149@asu.edu>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.com,
	wqu@suse.com,
	boris@bur.io,
	mason@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: tree-checker: reject extent owner ref without simple quota
Date: Mon,  2 Nov 2026 23:41:41 -0700
Message-ID: <20261103064141.2224566-1-smish149@asu.edu>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <b2c34370-3a6d-4864-8093-654288885616@gmx.com>
References: <b2c34370-3a6d-4864-8093-654288885616@gmx.com>
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

On 2026/11/3 16:46, Qu Wenruo wrote:
>> Cc: stable@vger.kernel.org # 6.7+
>
> Again, use your common sense other than fully rely on LLM.
>
> Will drop it at merge time.

I'm sorry, that was my decision. I thought a hardening change should go
to stable if older stable kernels can still hit the issue. I'm new to
contributing to btrfs, so thanks for being patient with me.

Thanks,
Siddharth
