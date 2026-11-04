Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759194;
	b=YdDm5aHseFtjTPYSTdJRQM8G4wvoFevYEzgCw/JX+x/Z2uXFVtZQTOokX65fywepM0Zi
	 y/DqcCoYWRPCsBG3rsb0/K4ZdP0jcHYmLUp0JbY1D6w93FCt9HlYkDFe7C93vxoyaNSf7
	 6orc0BtebJ3BazMo3svHsDhydWVDJwezDeKjme1KHsmVTt+47+mCGVua1rWpjinxJsIV2
	 YccvDi6lqU/fuR+UEUCsvslhJfMy7I38E1yXU+0n3/C297RUHGwaTRmguLpSaEOze1ya/
	 HkXH0rs2sRgr2qWHlsITwAvb+F1Kj+FOuzjqSGV1k6H5eGQ/z8kk0BGmUTwahYI0Lgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=zf8chmK4lYlJ/gNkcnvQsrfL5BsaQxeLGVbue6it71g=;
	b=tcf1tU9mgBG7Qp2p6SxaHdApW68/2ie1ORF6Kk3SGNjZ/iFhf1vbT1S2sA/NCKK8rDp0
	 1EwdiUOA/XDbmTl8lKlrq+DZOlmDfVwehJsyjji9b2SrCogKd0jFzZnH6ZYBmkiBfWHxu
	 H8oWCYKS5d6E78Xyk62vLsw5h3hp7c5KKcBISkV6hBAGiU2UB/CPLl4mDShC6LUanXuSN
	 ePDk4NCIA9K8oXFeM+phpoghsEVAt7YNHoM9swlT42yN9TADGF2QRSyZ5Mnw50Ab8QcjT
	 TMRH449ahw3FWU8mn+93Ok/Jt9cdkA1noNakbYoXjuFpeZ2Wk7NXF5NUGCnZdFQth4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdmC8yqS;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117C606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 02:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8117C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GdmC8yqS
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso356492eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 18:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759193; x=1794363993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zf8chmK4lYlJ/gNkcnvQsrfL5BsaQxeLGVbue6it71g=;
        b=GdmC8yqSzAfFyseLZkRaMIA67KXc6CcQ2kk97I0FutswHdfmKvOEVcRaKrlIGGqS9r
         JjiEkO5zGhAGm0zYWviqNrnlXYVQ7aqPqAwJiS/rE9kglVBVz+eWpiMVCRWYbhxrCrFu
         vWEkO0yCNt4xi9tF4aDZMVxpNmmB0QJKERu9H7wu0PUhhlJWyndSnGrqH9v65qCl21DE
         Gz9+68YWYIGV2s6pQ/x7M5P5M8qo1Wo5XQz0r0XE5WoMotCCJOoeNLtvUDynT+6h66Eo
         q/9LsiszrGwUaixfx8P7CizSxTEMveDmK+MXN4sVqVGaT7nuC5QYSTtM1/hgihe9lQxe
         ibCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759193; x=1794363993;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zf8chmK4lYlJ/gNkcnvQsrfL5BsaQxeLGVbue6it71g=;
        b=Z+GC6rQScJd0XaXLd6mJS2ft9lQOLS9Qhyn+N63S7L9n6d89B9O9xYhoBWf/N7P42g
         /PqMy5dwFubFHaW6Zr4YnYiiv7K6BxcmwDuMPbxyIYtbhipbaSmahpDwZyKW3jRcplpV
         OEhCSBuI2gV/t9pCQBPAfpJgXqbMtDV/FqKFu8S896jDlV76atxiZqLunpcgsSgWKwho
         XJmkO2pTlWKrC4JCEOhLZRkL+miKc5rfjNOsvHFawUV+9+Sj404hBpuvlmJwbRB/F73y
         xXCVAXajdI3ZYYkHH0RvGn45ZgCmSNq6g+6G8SQ88cvRHPyoRXnBzv1LuM31PFyGV2HX
         NedQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnj3a0HhkflIROhmyIqEXH5/M70ibv2V+dcMU7oBMcGYMJw6NERl0WBCd247PDIiY/IKsESPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+p4ovT7MjLT4rCCaIePhfw5ghQoBUJcxOLeXWDMyShFrgNtQtx
	HtXk3+yIWDnzUFXBvUXW2p3+KcXLl2Ka4ztJVuThNy+9jzNGvXpB2a2R
X-Gm-Gg: AYBFou05Ox3weysZorBgpAXp0ChpHV/fwrK8R2EKmVWn5l/dA8kuAQQ4kKf7IpmIgAl
	RmqACRYsIsbiJ3VQOywbvXyol3+zALqiB/6W2YN6nPUIEUKKomLk/DkGCTnjht6klSERiZQRWo6
	lMBbw5wSQysK82ujg9hNIQmgoAmVOyRJGwtgLqv0P5TnZuBp1sUJlknm/zRSNnNT1Ol7kSZFPRe
	k2NYlElU7dMJtUZOGEgptPOWeutNnwqMSqVCnktBq2Cc7sxhSv/J9bZUCfhAsKSwaoBjiwPe8Wz
	di/GXH+bq8tZPA8BTh+FnbQRljIoaNQ6AWSMiML/6a/1yQT9HKxKItcdfuVEFXaoAl9fd8d8aSq
	ASvtMwjEHXPhwy5HCoud4K6eYkSVVSUR2VqYyyeuX2Uu09djd4h33b3+CNEMmzTR8XVME6UiNjz
	aRa5Ld1QJeJYl7xwL6cbaJNC3H++fWqZSGLWgXl46CJYHJZHoY8Y4WJuI6U5rsoZxZPxIW/tB6r
	nyJbsQjwxeGUfCzUZda4koLJy9cRQP5Fw5JbrhchoIxKxxmUXB2VYlMBlUGSSUo0Eu+vNVZr2q9
	G5xqyyMbMfs6fA3Ow7L3ON+58BAk7zY3MBYLNfBcvvRlQilK50930CELVDsDMvtSrDbp
X-Received: by 2002:a05:693c:4142:20b0:36a:6106:4f63 with SMTP id 5a478bee46e88-36a6106506dmr15884374eec.16.1793759193308;
        Tue, 03 Nov 2026 18:26:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm2818065eec.24.2026.11.03.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:26:32 -0800 (PST)
Date: Tue, 3 Nov 2026 18:26:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ping Cheng <pinglinux@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] HID: wacom: Access shared touch input by
 rcu_dereference()
Message-ID: <auqXxlGTgwoAqmdL@google.com>
References: <20261104010108.21895-1-ping.cheng@wacom.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104010108.21895-1-ping.cheng@wacom.com>

On Tue, Nov 03, 2026 at 06:01:08PM -0700, Ping Cheng wrote:
> Allow the __rcu-annotated wacom_wac->shared->touch_input to be accessed
> inside an RCU read-side critical section by using rcu_dereference().
> 
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610180015.KsRqmoTE-lkp@intel.com/
> Fixes: 9183319a5ba4 ("Input: wacom - Setup SW_MUTE_DEVICE according to the order of input registration")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Ping Cheng <ping.cheng@wacom.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
