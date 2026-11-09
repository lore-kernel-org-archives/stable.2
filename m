Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240182;
	b=wKHP1o7qzEMs+xbTnzLlLH27bOGAVWJGnSeg1AwxvJmCzaRdQPrfFaF0A/8EgqJ7MWwv
	 AIs45lZQfxnrgbQJ4Q2e3iUWlYmMcGoTo/O75qZvtKaDGLRaDejHVE5zUNmqnhAkRgrFu
	 pPCUrTx2q2dobh43jrW456rh1LoNT+CjnI1IhTO4lkBSAhANVLsqxPcmg22j5eKF/NZ0U
	 mLGN1A7rmbRswltr4iBNAXh6v6aAH9pBkU5gsPjCuh8/9V4N5d0uJ5FF7PsWHRlJi3oOH
	 i00M/dWiI1gISK9F+KISH8IQpr4HNPFh0kXTdDKg+iEtZaFq9Qc8ZJ/RtNZNwQCem1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240182;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=5bk12FHQT4PypzlkZkgfKj9mgtiXFm38QoEdIbimCXE=;
	b=svI4iFqJmQur/Ymcno5rT9R96dUX9yGjo1XhwOnzPkZ2XKKh1qsv+22K14QqzIPSb2gF
	 PJQIxHtRETfKqR1/hN8r/hz3ftf9qsQFwDJa5MfzBM52yKiKeP165KearKD8fAHXVgwZn
	 KJqR8OKBT2zHLVAc7ybsA2vWY8mJ5OZf4fvJwh0eLQW+NOe2zUkbb6gI029CGPQ6iZSgs
	 6KUj7VLKhs2FcLO147WPgOEAXmSkPrJRw0uuy5o2REy6CpQSK8y5zOJpxq0vbVdG1wMud
	 +YbBwmBxkdSLEQfRNOdx9SXOy3ih8tfRDHkV3efP9YCIyZ+0LH7Qr+2T0RSAQMc+r6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=HfnSI4RF;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EF606EE80;
	Mon,  9 Nov 2026 16:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 184EF606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=HfnSI4RF
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNZLq0DLWz8XsC8;
	Tue, 10 Nov 2026 00:02:59 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794240179;
	bh=SIB8DhFbZyaBGt4m/wXxeUj7iGeiLyG50/P13ESs9qg=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=HfnSI4RFAxJLC9HvSUD9jYu3Rm5WeKkGcD+G4+OWTM0Hqy0YAHSv++E6DQRe6yNE3
	 a9dK26dL+SChvM/gF0kFE1O3kzIiBzCaT+2/jbBUkZQ3vCgS6uSk65IsKBCAFOr3Ly
	 zNAdGCpKmdVh+YYvIm19h29o9sj/WERtG/TSxSSjBhWp6xkeeoWzx61L8SwkR6XaGM
	 mRDuToncDG9GIOm0XOyHoxm2bX5DcNp4CxqFfpOTkbsNpSiwOIzHfPb6yVN540edSp
	 fbnC18GBHQQ5axYpPokCreHhyiCpkkORJXxJ2+eymG9L/Ii8hz1m5dp9peiFzatF6L
	 yf/jb00dJdOug==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A9G2Wla002317;
	Tue, 10 Nov 2026 00:02:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 00:02:34 +0800 (CST)
X-Zmail-TransId: 2afb6af1ee9aedd-a9c72
X-Mailer: Zmail v1.0
Message-ID: <20261110000234827nXRPQjzsInWFXaAaxeF6N@zte.com.cn>
In-Reply-To: <avHknBRJnZPpAIke@ryzen>
References: 20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn,avHknBRJnZPpAIke@ryzen
Date: Tue, 10 Nov 2026 00:02:34 +0800 (CST)
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
To: <cassel@kernel.org>
Cc: <dlemoal@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYXRhOiBhaGNpX2R3YzogcmVqZWN0IGludmFsaWQgZGV2aWNlIHRyZWUgcG9ydCBudW1iZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A9G2Wla002317
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 00:02:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1EEB3.000/4jNZLq0DLWz8XsC8

On Mon, Nov 09, 2026 at 04:19:56PM +0100, Niklas Cassel wrote:
> Again, this warning is reduntant, as it is already printed by
> ahci_platform_get_resources().

Agreed, and thanks.  The KASAN run for this patch printed "invalid port
number 100" twice in a row, which is exactly the duplication you point
out; dropping the warning leaves only the skip, which is what the test
exercises.

> And please send this as a patch 2/2 with the libahci_platform patch as a
> patch 1/2.

Will do: 1/2 libahci_platform, 2/2 this one.  Since the code changes I
won't carry Damien's v1 Reviewed-by over; he is Cc'd.

Best,
Shao Mingyin
