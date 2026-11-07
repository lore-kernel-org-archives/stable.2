Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066241;
	b=aAlHRPbnMEwBuro0Yk1+kcR0hoLgakXk4hF5nx+lzwkx9VyOv2KQLgskqM/jfCn1yj4l
	 QpGxQTtqoMcOdS+VsQ0QuWi+IG6CxOrm7xqW7PdbTrG/k2NlWkmirhT9Gk3P82tu5fkE3
	 Yn4mv/r+Cbqw+WW3J4Q4zsHzpqCexyMNPUhlDvLzSiII1EWg2nPurVtmqJYmntYrOSQ4d
	 vba0U1xNCO/b/6D9ZC7ClY78vQWY+kLo/I9qSQ/CE3kqrXlUIi3L5DSon/bptdAdRr2ur
	 4ilsE2xHSjzrbkGVWg9scrt0iYItEDIVM/pRq1LibV1jCtdGxDgjr6RxH5gF/NcBUoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066241;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=eYxgXranWoSQlhCoeNmLdUDwCImCfxZkTrCYXT55ZLU=;
	b=cpMFXskbrTvwZoInPxvIYTjrx9cnVxOttefrCoXWl9IMSzlL0rXiGO4WecXKFdvPZE+4
	 Gf37AZ1wTJ0RsxGm59D64UK9ylu1dklyB7Bkze3Kyi3UjJGhb7dFWnRjS4fTOWbQRWmLw
	 nr3WNRy5DAimlXxmCGFKJ4gsuY0lGFSo9qppfTuNhPlOZB8ivs59z0krOA1NpnWAR//CA
	 qQjmkLSIZBsQCGOGK3TDRZngXIbeKrLAN6fmpDbDXUCOJNIRDJGnHFML3zilk3YLDy8vN
	 z+6A4BXdveskKMZytIMRxqsecNXMrItig4zTQNnXtYY3JbzpnagdRDTltI+EvImcWVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kusi7ac0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6C606A32C;
	Sat,  7 Nov 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kusi7ac0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764801F0089F;
	Sat,  7 Nov 2026 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794066240;
	bh=eYxgXranWoSQlhCoeNmLdUDwCImCfxZkTrCYXT55ZLU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=kusi7ac0w4ZreYG2a6XTbtQyXG4p6FRKlPIzlZOMRnZBmkH2TqqAQIk+E6Bms1rJx
	 zbz6d/RSXwozO+IKr2M2kUCWl85K6wWtsZLRRsGv8itFwX3yasXpug6aTLE/Lt0fcj
	 gVHyVcq1Nui1HY5r5BFMD+hiw703YT6bjMCRGBm+rZn6kILhDLb3x4sTS67GL93SBF
	 xWaJzGqFMZybHGLimMfA/qrRZD/Yuafd8PXqVny7ADnRujsuh0b/vBYAWUkYuH7a8N
	 uEokovwOalO3BOoJKroPLZTUnkxfSa01HfcrcJ1T2F3Vturm/4UNSMAeKS8KdWUSVd
	 /Gtd+w7cJLnQg==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] media: venus: vdec: Clear streamon flags on streaming
 errors
From: bod@kernel.org
To: fengchenguang@kylinos.cn
Cc: vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, 
 bod@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260930042417.191675-1-fengchenguang@kylinos.cn>
References: <20260930042417.191675-1-fengchenguang@kylinos.cn>
Date: Sat, 07 Nov 2026 15:43:55 +0000
Message-Id: <179406623573.650304.7316804357231787933.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=bod@kernel.org;
 h=from:subject:message-id; bh=zLU9b3PfIsD8Jz99iK2c9VmRUcnT4iDkqCQDMoxJujw=;
 b=owEBbQKS/ZANAwAKASJxO7Ohjcg6AcsmYgBq70c9+UqbkesHh0vb4BCptwx8RIhgnJLC3hHBq
 ePya98qtJaJAjMEAAEKAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCau9HPQAKCRAicTuzoY3I
 Oid2EACGmzztFGQH3bO9/HTyq15xv9zcOvMYAEpSZIg7IigHYTsQwcnnUt8cjbwYl9RUTfgLeiK
 rEzTZMiXspyCRVlq3LUF9+bIrNwAqNGj9daaQ8w5GLNZYteUfc1C11BrgRMvkk0C7cYPMW9YE1J
 19JXqOlpqXvjB1ZEHtfb5pMmR8fV3IKjapjCFcfe2khepdzYghj6kH8S7dRJDukS21/+P9hAQ9W
 dnIiP83apCQ0TL84XUieT2CbkLuMBlMd0IlY02ikrLvV00iRRy3wW2TYezM/u/iSISlzZpSD946
 J6ArJOT4jJN2eRlVWTRJ1sqKfRrKCXIiSietAGRUSLalEDsCFaEpjLB7VAep87KsqS+48EunyLq
 LPSSrnPQCSFW7pzXbKKowQY0nvBgreIqFkCm6LPfpW9WFP50t+dfCUND5dIFeKt4orT2Z9L5r/+
 HGonRXQqSDuiUDS+138URvfcSYmdaSANFOGpQB9HDa4HR3C+Az5T/rUEEUAeIhpV/ZZakwP6bYp
 d2zbcVRTGhJYDALmGKbDBE4NDO05eK+tgPT1SrxAM8HQ9mw74EEFqiAVyg3TogZE7YZ83yd7YEv
 KfXNTJLJjllXigbX42472DEQX3q9/6PzgvuF6CJ0RZ+qITZLLarR6nQxnEuzr0E928BdqeR+rHi
 dQ9wDBxmqjg/SlA==
X-Developer-Key: i=bod@kernel.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

On 2026-09-30 12:24 +0800, fengchenguang@kylinos.cn wrote:
> From: Chenguang Feng <fengchenguang@kylinos.cn>
> 
> The decoder only clears inst->streamon_out and inst->streamon_cap on
> the success path.  When vdec_start_output() runs with the decoder in
> the INIT or CAPTURE_SETUP state, it still sets streamon_out at its
> done: label even if venus_helper_process_initial_out_bufs() failed,
> and the error path of vdec_start_streaming() does not reset the
> flags.  vdec_stop_streaming() skips the clearing as well whenever
> the hfi flush fails.
> 
> In both cases the driver and vb2 disagree about the streaming state:
> vdec_decoder_cmd() and delayed_process_buf_func() keep going as if
> the queue were still streaming, and a later capture streamon assumes
> the output queue is streaming too.
> 
> The encoder clears both flags unconditionally in the same
> situations, so make the decoder do the same and print an error when
> the flush fails.
> 
> Fixes: beac82904a87 ("media: venus: make decoder compliant with stateful codec API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chenguang Feng <fengchenguang@kylinos.cn>

Reviewed-by: Bryan O'Donoghue <bod@kernel.org>


