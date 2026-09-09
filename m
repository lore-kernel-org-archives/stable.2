Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89957D221;
	Wed,  9 Sep 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970655; cv=none; b=Hgphc5vC++RxaxsXE7PXu5eBRdvr0IRsyUh4y+SdJ8Tm0+8wFxjsnJIIdHRD7jIfKnygSYYFyr/6L1Hw9ziN1bBM4WYSrokvBrE3gbBjg0u48NgS6Tj66DkCmerIzWLOrq0+RDwjocxKPXt0gAo4MMUNE1TxQxbfRjz2cHm1OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970655; c=relaxed/simple;
	bh=k8VGBb8PaDkc2yd06E/IJh2YobUiaptSlY9ebsPQNOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA3QnS/TrtvjOgfvYU9SK6vYi3gb/cC05Vn82jv9QAbMsuPa6mJhxbOE+hrKFJbvLj7Ts4lxsaO2vggcw+8ey/UdK/g5n27u2MuH2KuSvwmfrf2vkwVA9/j8EF7JBcgTGiOn84DLjHMZ27YwUEFkEzTNm+PHYy9zjDtmPaF0J1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUCYhhac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUCYhhac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8431F000FF;
	Wed,  9 Sep 2026 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970654;
	bh=Qhe2qNXetlQqkFY1S6O8BoiQ9ETn0fwLz5nwk41DypA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VUCYhhacUnIeH3MGrESrRcuKjnLBgv8kOx5gW6pTTwhEFKoDEAIQ9cEK5mXzghuf/
	 78Ly+C0CMaXb2F/x43rRNd6eqO4DrHYvyAMQ9NgwaOwXM+iewa1rCGJDI6vFgVh3xB
	 JmBGxSs0geyg9jrGtrcV7q+1KrJcBkGA/NMbu+Vem/4W1pdfX7b1pVTey+HY3M/jaZ
	 tsFcOLYJxIzIGR1QIIseWmJ7qeRAnN3fX0PxUN/iV4svUUbXbMAgT4H3woizr68HKg
	 ChsB4xwNSEapEwwgyKJQD22MaJe7AvqjORFKttPf6JSC0rRjejD2j0fA4TiSqFaGsd
	 yA6bUOX1f9DXA==
Date: Wed, 9 Sep 2026 18:17:26 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kathiravan T <quic_kathirav@quicinc.com>, 
	Baruch Siach <baruch@tkos.co.il>, Dmitry Baryshkov <lumag@kernel.org>, 
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>, Manu Gautam <mgautam@codeaurora.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] phy: qcom-qusb2: sort out register layouts
Message-ID: <oudk5kc7htbuodfuszus4wqxcbfbrhn2meuk35cz5bms34i23j@jywq3lb3q5db>
References: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>

On Mon, Jul 06, 2026 at 04:53:13PM +0300, Dmitry Baryshkov wrote:
> IPQ6018 and MSM8996 use the same register layout, however for historical
> reasons ipq6018_regs_layout ended up correctly definig TEST1 register at
> 0x98 (because platforms using that layout didn't use autoresume), while
> msm8996_regs_layout used TEST_CTRL offset (0xb8) for the TEST1 layout
> entry. Fix handling of the autoresume register and definitions of those
> regs layouts.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
