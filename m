Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FE3932FA
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596071; cv=pass; b=NMqLqLMmey899J+gvo+SAbvjxAd9Vus+/f044yF+1YG0BI7V8DfTqAeOk8c1kWLcNLY9OC+6SpWE1z8L6B2S+l1SKIhMDw/BbjG1tywjcUSnbr+AAQqPsms96p+8Rjt0dQtQszw9Hrwmt8vNUypl9PQ7RBUcaaXjtWtT3m5KlvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596071; c=relaxed/simple;
	bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVeaQVCVyNtdB7Fyj6XPH9djl1ib00bcw0w1ZLhquv4XD+THsbyr/ejZ7b65CE3jtJ7qLU8/V2WPmT1E96rax3Nmbl/6jBzMgwPVe6ucCOr9Cz5lfbdD4epEEHaLpwMnA/ORr8fKCVwOS4ChDJxrklxTT2P67DkSqV3maAtEGjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO33PMB8; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO33PMB8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69f4acf7047so340102a12.3
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 07:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785596068; cv=none;
        d=google.com; s=arc-20260327;
        b=CpcZZUegY7SbVVEeMXMy6ZCH669oBIO8dkcoDMaEJPIRmV1fKs4oqXYCfYca9/pUDW
         93X9Y7U/XcH66mgnCD5dwO2eDDkDLpZIOZaMh37D+UBaNmd3sOVlYJl93qJkNEvQHUdW
         bLG721BiABVYYH1l3rLXvrZ+7mhwPmPnQbkwPWYksZ+wAbV4/XYSrIfOSQ6W2qk100ZT
         UUhc7qHQ8TCEtYM/d4vymmGbwW9zVFl+FALNR2NjH6336ksYUXUhGE0b8OtjPg3af9HI
         4B/6PBqf6J9PLOAwSPm1EyIgTS+3CxBEDj2H8EedunnZC91FiT0Su8YRqn5QWOM8EAeH
         uJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
        fh=FAFxAeygSavrCYS0cPA4/us3bdxQgH/Pr32BZNdaHdw=;
        b=Hh+tlKUNL5iEhzenJH6/SpzoqXaBAKz7G3V/TmSAvJ4RQlIDK5JVbcusms1t4wycsS
         SC9L0pLZoORKjhbLbdDNRBIL0NJZB41zHHWPIvLythMV4L2IvSlZlN8NKg2S4HymF2f1
         lzXoxyoCEVQFTVe0Lth6TmxYxzdOAcIrv/dOZfJZc91fl4aJeQbk9BxkgBu8cGk8AW70
         VRL02RGbvfN/o4cenR2N43UZr2cA5/a11SytyhhnJO0sp+47hPgEkvcdEO5XcvQ9WQqe
         o9plrxRGiDAkI4x4MgH9GoN9DOcKqtRmS/OdcfvYEn9bwK2Xx1AvjoBNhZyXp81tZxu+
         eR6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785596068; x=1786200868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
        b=SO33PMB86LWO56A81UQNiunI1hVkQKQiC+trgH0uAQti1jekX7WFUilbHx7EUO3Nj0
         qn3OixXsCInZ9cDrOuvvug+EQByMZDvFO1lz14gwcUWKSQY7vp81gV7b7lpsxFsowXeK
         qFs7ufyuEX0uubWLezN4TRlkAxHmaj3ejl6mhsafHxYeAyLRm04h/meVHMrMUQGNAmzF
         Iu0mef0fccay/RQ/MsLYVnNCPhltwxW39b7O0BKSY/HNTA4NezR5/PVFmGUTYt6U5qqv
         dSHtCXpj4tKq5Zi2szBalPnjEcdy2yv5I6dWo7XFvrxbJc9Ufuk7e/9ZR6ap7XoZydiu
         wF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596068; x=1786200868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lALeePGZVy7EXUBDDuEbDUR+laeZz6c4FLEA8PHGpQA=;
        b=N0/q+siDf69Dhvd1dJOEWZWF7lbU7KLrDp/Oi4FPdBwh7IbXDlA+M8uqbkiAIdiFW0
         b67+yX/X2V8K/rTFwBl47uw4/0FlGlm3M/P2XPODY8bHAqPEnLhwQdBM32beypcHYfZN
         um2OBQ5yCqITQdionPQwPbx9D0O052NJvpHarZBLAP06IT7k6XNI2by74v/PvJmOjgwv
         FTB7/D+CyyTm72Xb0GY3//rUL7IpbYBJWIX+eay5IUj4zBkniICejjtVS61zyWXWi24/
         wfkxIKtXNpQs2EoyWO4Myiz4LL3WWN1v7afx94yexlovdT4y1NENn5T73ORe13yLJtgP
         BRlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcmUdYMl8XBME/JIeBb1mP3lupoXdwFqDWFNSz6ofyu3YQsZ4n7qZNFVuF8e5wtP29OmU2weE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGit6WbF0sgIC75Pb78aROWM6Mrxqpc5wp3nM8gnx1TpDNxmw
	N5Xoep1mQWIjDbkeI2DpiZDLuAfY+DYx15VlcpGg40uZ+eEVgGkqzJBx/N9pw47ytx75gh//jbA
	LOmMk3aT+o0srj/SpTs09keKZ9ifFcSc=
X-Gm-Gg: AR+sD10NiI9TaV+dw+7dPWN7pPajBMmG1OM5RIQdFozybn8+6XQnQFBuEMIIl8PD5Fg
	HqB4InM8j2GrUpx1cXFQkXKLLII2Ee/v4qnksJAIXYCecau8qjDfMK2OTHIb/t6Ojtcf5B+gQrc
	7+PonFKGFGfuJ5eJ/PIwPCimkWs7o5vLwEwdG7aIO5ahdQ2w99NwJjfhQUxAD4Moc9Rhtho/Bnp
	LlOpJ4I/SugotiJi/oMVZUFIywoz2xsWPryiYF6cZjqziXRDMEG/LB7TLV++EbW3AWKGBZFZELA
	xYfjI7i9Qqyo73x+juM/UaiIBMateLSsVBziFAwHxfsPZFdIh10yB1Z3/FrHm3sh3Zmci4ROkw=
	=
X-Received: by 2002:a05:6402:280d:b0:698:d8d2:df38 with SMTP id
 4fb4d7f45d1cf-6a0a7d14af4mr1792429a12.2.1785596068086; Sat, 01 Aug 2026
 07:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com> <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com>
In-Reply-To: <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 22:54:16 +0800
X-Gm-Features: AUfX_mxege7Yh6aPEsZJXnOr0qQ1CCnaaBLHWtdaqnDVHVEc1876k_pZtjV9gkQ
Message-ID: <CAAo+4rV0ncEcMGZVH+VHScJozqs5L4C3S-mW77s5GyRKeQ78Zg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Sat, Aug 1, 2026 at 3:25=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> We might be better off removing the le_conn_timeout completely and
> just make hci_le_create_conn_sync -> hci_le_directed_advertising_sync
> wait on the connection complete directly rather then using yet another
> work that can then race against the likes of hci_conn_del.

Thanks for the review, I have just sent a v2 patch to remove the
racing timer completely and let the hci_le_directed_advertising_sync
synchronously wait for the connection. Let me know if anything should
be further adjusted.

Best regards,
Chengfeng
