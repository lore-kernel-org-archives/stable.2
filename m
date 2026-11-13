Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549933;
	b=2jPByQpNpECSDnzUwAE7dLEwgX+4vFcQuAYUWlVREjE2j0lcpI3Osyh/OOvJh+lsKs6g
	 9VIplhLmw/qME+/+aKwIFapqJw+USWnoN1qyPhZy69sIlhy/z8s45kRZZnLwgZbwjog34
	 2nNx/Pq0SXNKsD4OTzkFkWw5tyliP2jUiwF35Xr3eIQKNHjun4n/LdkQCaJ0KGqj1IDlK
	 cZJ0/PbUjcjtQ4Df1RmKgx9CyKb02pEO8PE/Bft5ouIc7lEWo18LVq2qFavnoGEZfJoyc
	 Uvg8VHSB4IeTQhqhaBXjfP4K011pijC6llVlppdWyCT/Wk7GRc7bwwuXcQrfyhpkn4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=vYNnqpv5ra5Do0/x+PQ75UVuIRWg97u6BznB3aU7cnQ=;
	b=4kB/wZ9cPDkoylA1KcBMRz4492faaYTo3jSOPv0e2dzr5Gihffyp3gM2gYEiQBlSL/YV
	 UnvM9qSW8e2k7pYjiZcdTo2wUotW+ljRAGJZiX7X/FL8WGxveDT5kx0+EYS8p9eu6l8Vw
	 H9W9cwqsPFnZ0OKOvPGpxI00vzO6W/yX+2IgtRCVkYVzBHDhLDkoY61TSsOcLc/gka/Ny
	 xv1RmACfFjUE/Z6MHb8KpGQrmFr/Wgzs8G3hCEvQG1a4rnPDaCaJXKcj92TTIJneupkak
	 XW4u+CzBbYxut8IO/Ar1zf5WogTF2npK7BKIIebQ0vanDmBKOS08sHqbJR+pYRHzz3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="n8NLht/d";
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B38606A321;
	Fri, 13 Nov 2026 06:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=n8NLht/d
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQmvb1m5wz8XrrX;
	Fri, 13 Nov 2026 14:05:31 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794549931;
	bh=d6QFtlYbFS3rLC3ptLnfBFGhLsTg8baDr960zJpwHqI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=n8NLht/dbUDeBicrHPfMzVME2grIgPqVGRNqnPXnxYDDVdeUK2DQ9tvlsyveaQ+uB
	 PUEgTSQzeHUICfHIWqwPfea9MlRmr/h1kObe2ga3hDfNXvfRV2LafkmcEip82whIel
	 5clY2Q9+twPLdIud+AydITjIgM2mSywI6urfVRIIfNeppWdjx183Hy0ZnRMbrHpU5v
	 IDGOqJX97DnWNr/tvVTv1bTQQpQeT9e+I5W0wENeUms3nypxZD+WBZI5qj2Cniee/n
	 dH9TIWfnvA15DhyS/SjWKhllJ+U1k1P49ERlhuJwT13jcPfiOwl9nJAzqF+E0Ug4No
	 IWmap0S9Z5huQ==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6AD65I5s055166;
	Fri, 13 Nov 2026 14:05:18 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Nov 2026 14:05:20 +0800 (CST)
X-Zmail-TransId: 2afc6af6a8a0970-5ac6d
X-Mailer: Zmail v1.0
Message-ID: <20261113140520013r7cZBG_pl1-iZRH4hIR8x@zte.com.cn>
In-Reply-To: <589669fc-4cb2-429c-9960-1c89efb597f9@kernel.org>
References: 20261112220120113cXLhRk6iDVvhfgGPoZ5vJ@zte.com.cn,589669fc-4cb2-429c-9960-1c89efb597f9@kernel.org
Date: Fri, 13 Nov 2026 14:05:20 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>
Cc: <cassel@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxLzRdIGF0YTogbGliYXRhLXNjc2k6IHJlamVjdCByZXNlcnZlZCBiaXRzIGluIDMyLWJ5dGUgcGFzc3RocnU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AD65I5s055166
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Nov 2026 14:05:31 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF6A8AB.000/4jQmvb1m5wz8XrrX

On Fri, Nov 13, 2026 at 09:20:15AM +0900, Damien Le Moal wrote:
> Long line. Please split it after "dev,".

Agreed.  I'll split that line and send a v4 with your Reviewed-by on 1/4;
patches 2/4-4/4 are unchanged and keep their tags.

Thanks,
Shao
