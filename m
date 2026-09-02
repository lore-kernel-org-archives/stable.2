Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2B1DED42;
	Wed,  2 Sep 2026 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316502; cv=none; b=L+Q53EbfL/D2j/68CLjAdrytsqHZjf/ZxFBMtgcOnlxRe6vd7xpH5WJ3BMxt1+TDUtWN+AcHlmyV+X7aVl1vhq37sdOr/EuNIwj4xcBQ2u0ffYVOJrtfNxwHqbcwSTnaVqtQswy22d/exL7cQqdhpyisJ+JT3+AF88GcOE6Jrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316502; c=relaxed/simple;
	bh=lMA+M0mYE472xm02DqxSPxnp973C3QaokmVq43fEKQw=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=ml/itze9eImftOpih2NqDUskWYT9xLRtYBq1XOVVd84SJU63pPUTIufd0/sSFdQt23+aTdHrzzgxmlQv+x096w0tqPfwYUtR1SEMArVMjg+xmQD4nPE9jqRXbaGH3c34BbZON2zV+zCSGZxgRkzJZVDbb+/t+ShOqx7x3jZ9LDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Pwu5bXq1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Pwu5bXq1"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6822YZuE42248924, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788316476; bh=gUGocE1LB3Q4EMK+YnvbT/S84KdDHEL8FfQFeQ1xsbk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type;
	b=Pwu5bXq14tapwmmI30aKXkUN+eloSQtGjTR11eW6xTchCykT60v3w+Wa9t02rZi3Z
	 UFU31b2D2L0Z53VXVAWlZm0IIkNAqWfr7nNn/EfHBkuBeartaXkrGmrPe8fY9xRp3h
	 2dlx9QNbqoUWE5IjZgpsZiCYeQY4FhzJrgLYwVl9TYQwAWK/UQ2Ej5Q6x4Xq2LEvir
	 KsNU7qDoSpxD4ttQ7347ZgBPx5JC/FvxCtLesUl2FNJXhVrl0hS1iM8ZjtPw6gHO6Z
	 3O9CRGnlR6JmLHyGcEjc62rBxigdSusZe0eUlY9lP4pZJ1gLjt+b5znnV4e6SXw7zZ
	 Zb/B9pt4GguVQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6822YZuE42248924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 10:34:36 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 10:34:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43 via Frontend
 Transport; Wed, 2 Sep 2026 10:34:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yi Cong <cong.yi@linux.dev>, <pkshih@realtek.com>
CC: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yi Cong <yicong@kylinos.cn>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields
In-Reply-To: <20260807081006.240450-1-cong.yi@linux.dev>
References: <20260807081006.240450-1-cong.yi@linux.dev>
Message-ID: <b1fa10dc-876b-4db4-9f59-b21dd31ef345@RTKEXHMBS04.realtek.com.tw>
Date: Wed, 2 Sep 2026 10:34:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yi Cong <cong.yi@linux.dev> wrote:

> From: Yi Cong <yicong@kylinos.cn>
> 
> The .ch and .bw backup fields are swapped; .ch should store the channel
> and .bw the bandwidth, matching all other chips.
> 
> Fixes: 0194a95cbe721a ("wifi: rtw89: 8851b: rfk: add DPK")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

7e080e17ca38 wifi: rtw89: 8851b: fix swapped DPK channel/bandwidth backup fields

---
https://github.com/pkshih/rtw.git

