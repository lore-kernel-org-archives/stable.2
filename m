Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188988;
	b=hiHGSbS48vE9N6eR8zO+f3GkXA9EBFcNZn90bDpWzpCD39an4680cIoqiPzgS0sUFsb6
	 bo8UwAT9W03iLDPc+wbZ7CZba+8ZXNoeqmLD1+iIw/Huk0n/GjNqMlZoY+i6IMaj49ag4
	 BRqL4+hBhXxltHGV03XTLirj78Cv75zLYM16jYdEFl5LIrOP0dRj8zqaGVTljQeSxszMP
	 sBSN3whKxgwGsEgoPlxFA+7TMmkfZ0GQGsfAf5zIRt7KRKPthTMewOLeu9Q+a7i9o3twB
	 05mC0Fs3I9tWZY+/3e2sAqr8/KdqXx/7/cMvIfb+DgESUn/KfsRULwoX5VE+YF4WLAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188988;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=F/TLS34Kc3LxfQmnhQkw9YOww6pvgq77Emsd/gfBa14=;
	b=3EsNKHwRXWN8GpXjfdS+zvI1jII3AHzmPuhLLrrZtA5BuGuytEGv3UGjR8Mp0uX/qOPS
	 DZ88ccJh3zSPWtuKAJ2UWEpal7eLgZDzhnJpJ2M4+7zLU9f24VYmF0jsUnrHQ0lA0oss7
	 eN0SD4x/UVJ3bIzPzeP4NIm70UF7eI0xPXWHJTxoGEZsQLP6wGk2LCNEoB/Ut00yLXXCr
	 vlZAnw+gfBTDUfFFD60bjbLYWUzME0Pg0+PM2TC3lr1/9u6vMR/jn+yiaCja6aK36obAG
	 BYi24eCnFIx78ZjiPbMm/KpQ1ah9V9GmDrjKsAq52jFYZ2dnGLhr8mDjs4Y40vpckng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b="J00t9+C/";
	arc=none smtp.remote-ip=115.124.28.76
Received: from out28-76.mail.aliyun.com (out28-76.mail.aliyun.com [115.124.28.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF034606A31C;
	Mon,  9 Nov 2026 01:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF034606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=J00t9+C/
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1794188975; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=F/TLS34Kc3LxfQmnhQkw9YOww6pvgq77Emsd/gfBa14=;
	b=J00t9+C/61COh/U02okoFJUzgV2o2KRTlCMh7dVKhrmSM6eTG2vsVohBmf6MCwAU/HiJPg7cm7OtC+DYH76tT48oA/x5r77OnMMpnDcJnK+AIFn6pObckfCR8P7nCX25KpvpAzl1nozanJ9hYYN/f7RzbC2sCLDxhPhrAOgpsqU=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08994493|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0569483-0.00121446-0.941837;FP=5724750288717166808|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=guozh23@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jzg7gAJ_1794188974;
Received: from 127.0.0.1(mailfrom:guozh23@xiaopeng.com fp:SMTPD_---.jzg7gAJ_1794188974 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 09:49:35 +0800
From: Guo Zihao <guozh23@xiaopeng.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ard Biesheuvel <ardb@kernel.org>, Matthew Garrett <matthewgarrett@google.com>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tpm: efi: reject a final events table with an oversized
 preboot log
Date: Mon, 09 Nov 2026 09:49:34 +0800
Message-ID: <179418897414.2773996.1582380807629789288@xiaopeng.com>
In-Reply-To: <au3xM-7onNTtgceh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 03:24:39PM +0000, Jarkko Sakkinen wrote:
> Ditto.
>
> For all four address validation vs bug fix intersection. I did not
> check throughly enough to be exactly sure of all four.

For this one I'd like to argue the bug fix case, since the data being
validated is not something the TPM reports over a TCG-defined
protocol: both sizes come from EFI configuration tables written by
firmware, and nothing in the TCG spec constrains what firmware puts
there.

The firmware data is already treated as untrusted in the same
function: it bails out on an empty log (log_tbl->size == 0), on a
missing final log address, and on a wrong log format version. The
unchecked subtraction is the odd one out.

The consequence is also plain memory corruption rather than a
graceful rejection: final_events_log_size goes negative, the
following devm_krealloc() gets a wrapped size, and the memcpy()
appending the final events log runs with a negative length.

And the out-of-bounds write was introduced by 166a2809d65b ("tpm:
Don't duplicate events from the final event log in the TCG2 log"):
before that commit nothing subtracted the preboot size, so a
malformed table was harmless. The Fixes: tag refers to that
regression, not to the malformed table itself.

Ard also had a look at v2 and only asked for a pr_warn() on the
rejection path, which is in.

So I'd like to keep the Fixes: tag here, but I'm happy to drop it if
you disagree - your tree, your call.

Thanks.
