Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3502E7398;
	Wed, 14 Oct 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981597; cv=none; b=TJAWNCpmOJnPCN337frGRWz2Ps53OEi/telOMMvBEaIzTEeoN9mSNrk6ZYAPmHOYa/Rav8SAmRyO0aE8fORcsYl6GZH1DLf4niRiDH+Da564rb4C/SissCI63yhvu3QzRP/GQHs29P8NokWULnUXkzDENnYOElj3QPqvtgUihWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981597; c=relaxed/simple;
	bh=9H2UCmqYOHM22VUfW9qwY8hZNIDd/S7m+w0HuPyY2SU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NisNWI8Utx9FO7+xN1MvGKUQVD4y9krA7dtAcZZQH0GBdaXDagOuNDB0Mtzjpvp5gjhMk4X3Z1wis8MmP6U7BCvHPxoGaUBcA9tIT3bdjwy1RQnw+c8Rd81SaQ4QzVkpXy2TP2bpoM5y8OB0MLizU5QaQEYGFrrwxgOUCMCXaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0rdiRJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0rdiRJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910701F000FF;
	Wed, 14 Oct 2026 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791981596;
	bh=fSLYrImSeP5OZxk3Y2QxKlVVF88b+H4K44wWDBQCcaQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f0rdiRJATNtxiO//qKH+BCHCe19IHsFy8ayrgFDzdvRLyIwGsMwRYHT2chta66BD6
	 jge35w0hc//PaJgickEPhXSwDpDhkBqu1v5pb2MIC1D4q2zSwxoW62fmkVq8sxdTnE
	 qbzdc/ptGSUtSHlWtJxwT/2dVQGmVFzpx+K2/BwIzYK0lhRVdXMMFnA1+X/EblzUKY
	 a+ijnhfLoGIMIISM3a8hbsuwdRCoTsH2JlT9Se4MNOK4yRPDV00IKw8ur4+4NEtJ3c
	 MoKmGWapwWDtQVuQvSCFIWrzixsOh4UZlq7CzVb/03jypgflB4B7NJRIzHxyICO9l6
	 //3kkWDvfvYnQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Siddartha Mohanadoss <smohanad@codeaurora.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260916090126.2963064-1-lgs201920130244@gmail.com>
References: <20260916090126.2963064-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] PCI: qcom-ep: deinitialize endpoint on remove
Message-Id: <179198157973.38040.12670241698172958938.b4-ty@b4>
Date: Wed, 14 Oct 2026 18:09:39 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=313;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=QDazMUlgKBIpMdh4YUwrz6pBiQs3lsx2LKM34uB7VXw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz3gSXYXvXTMJSVSYK44vv9+OYRwjKz8iErSsF
 MmYDadDFsyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas94EgAKCRBVnxHm/pHO
 9b3dB/9Whr73EIn0wph97mjdQ4AqncsP+ZlkZxYmBdjaaz5RiMlrYWNnLjiXoBTI46hLB572ZSZ
 VBzUFU+37FThZDERkZKRhf3jMN5p9ycZnGoKDiRkmUUvCy7kb9QpDdF+UJ3Kyf5otuAHM/ZgCwF
 Rd0KgDTpDH2S4p6y7WwFEl0gKN1hhRYMpfVZsY26mbNCb3Yqw9LPR0H1AKwvSsRf9u9I1tpYhUm
 jLq/ArHiiHQIR/0XDAFQFhWm/ZjNzSCjoHi/vfkpg/j/dM+ei4DYDpaCBQ1b8xmrKA7FIoZ6QfW
 5TtTxf5ok46/u7Z86ZSbg9KFAl6N2SfNxpUobD0rU5aAEJRt
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 16 Sep 2026 17:01:26 +0800, Guangshuo Li wrote:
> PCI: qcom-ep: deinitialize endpoint on remove

Applied, thanks!

[1/1] PCI: qcom-ep: deinitialize endpoint on remove
      commit: 817c16e46609d60c22679d9145a39e28b1f6e164

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


