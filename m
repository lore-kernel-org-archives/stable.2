Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903961;
	b=KFB7UBZckuYsYco4DrXfy9r3UVQNNAOpkf66iGdXU7MTJN/RrCyHLjHDXddnlzVlZ3oH
	 nDNix7iUVHhOCjz96w9KItCCnnpltavuGLrlTjaIpZMR21F/7QJzYfnnGD+KfUwDopJuJ
	 mBDdTv57k6aMIaLX2r98j92WVx5Hl1onPUL0QSf+ocV63xuK65WSmrRxZ32t2rHQgT+XT
	 R2FrS2A3pqLy+Xy+fCr8Hsm36Elq9qFj6Y5mZVXMb0MWzhIpINNF9S/dzO3LQ2ry/4OAW
	 p9ZtgTPAC1bwCFCuFckRZkoHZYyRxuHj6npCElmGoI9lsDJExDfYT2HFJDHtUTmklVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903961;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1jP4FNNNGUgiAZze6J9RG6eDxXUSytXfVQ6OmzqR10I=;
	b=I09l1RaXPauqJyvMP+qA8wfo2hirZKmKrNhyX2MtiqDDfGwxSNrmpGJdhmR0ZBKidYpY
	 TedUuERCkNjAAKlcj1YAkTxIqD8FG66SD2Ir5arm0Soc6sguncweYV1HydrO3+008wf4x
	 uGUw4GgvuQWuMLmQIdqVf+v7crmCJqPwNLDxULojNe0UbGt2WpTTgibzyecABwlqiAZgt
	 moWm1hmIugixAmaDsxxrfb5tv04MrttRHNUv9PMKswhnKVwofSl5vTLyMg4UEMWGpUeii
	 eD9QhshRRLmZCOwWfcv0ZaBx/9GeW4fwM4deJ2h4YAzYliGB4tVgY2z3+zjKZvMdHSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Tt4/vD7e";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B3606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tt4/vD7e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916A61F000C1;
	Thu,  5 Nov 2026 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903961;
	bh=1jP4FNNNGUgiAZze6J9RG6eDxXUSytXfVQ6OmzqR10I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tt4/vD7evAdKOkUAJ0FSY6VCF/vSVDDSKyOycpySezKPSBouJfBVdR25QsHBug/I3
	 v4M2Vo9u5B7yKTs7mwomIQn6LXnrxJGdIQ1dPTRxJQfirZjBhNxzVZCsU1ETanT4Xl
	 OOca4B++IL31YGOCgO/PbfO6knTx7AIBgknj6MlZfwy5g7rCZImKLmUCRsO8+3wQiM
	 3LJt6pDe3qeiONxqvFTP0qCsu2QGFXxRxIDPVWWWuHzF6cKp7VSUyvL7K+P84ni3a5
	 Frfsav3eufrCsHUH5pZaBdQdKSAkVkbhSbdbfSi63EjxgqexI5P4zFNdSxDGIMLpvj
	 LAOhqksMXlLuA==
From: Sasha Levin <sashal@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Subject: Re: [PATCH 6.1.y] Fixed ksmbd: validate security descriptor offsets before pointer arithmetic
Date: Thu,  5 Nov 2026 13:39:06 -0500
Message-ID: <2026-11-05-1-daily-reply-0001-ksmbd-sd-offsets@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DB5PR08MB10062B7BF093BA770036A83AFFD772@DB5PR08MB10062.eurprd08.prod.outlook.com>
References: <DB5PR08MB100620A5BE5A4EE2F978D001AFD682@DB5PR08MB10062.eurprd08.prod.outlook.com> <2026-11-04-1-daily-reply-0002-re-ksmbd-sd-offsets@kernel.org> <DB5PR08MB100627622C33C426D3138E1FAFD682@DB5PR08MB10062.eurprd08.prod.outlook.com> <DB5PR08MB10062B7BF093BA770036A83AFFD772@DB5PR08MB10062.eurprd08.prod.outlook.com>
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

> From: Namjae Jeon <linkinjeon@kernel.org>
>
> [ Upstream commit 3474e1a304fbf9f7c996b24adcd519e031227a90 ]

Queued for 6.1 and 5.15, thanks.

Going forward please fix your mail client and follow the submission rules: send
with git send-email, use a proper [PATCH 6.1.y] / [PATCH 5.15.y] subject, and
do not send patches as Outlook replies.

-- 
Thanks,
Sasha
