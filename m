Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DC369985;
	Thu, 30 Jul 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433668; cv=none; b=nr2pbiPyIUuN3NCovGOJOBDFbVtZHEvuCZiOUHGKn62t+Pb8YJ5EpuJ7KemJ1YoQmk5J0SFDvZhew3vu9n+rJt5HaXOg8DoNbNKE0G0WCNesbaSI9hlgF8McMd+q9kYLQppamPOs1E7U0KV35aLSr6t7oCRNqx1R4AsmAoljkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433668; c=relaxed/simple;
	bh=e+0ok1JCx21GutzrmJHR03gizwPHvHNvaU/J1sXC36g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcyZvYy7DIQ6e3IJaU7VTKIK3lzRgYfAEZlZ9bhWSvfx8GoggNGIjhGVqAKr6nHl8hAXOCtSYlmoYY+A3oGdCQnIhOEqnb0dSQT24qKMWqkbwOLE0RN3Taz6h7SW/NEJCOQHJSrn2GCcfhNjj/divmCBvI/hYDdVLV7zwgr8eeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pw6S3AZl; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pw6S3AZl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=M8gGV/RkrR2DhChPfjFgBTL106iZJcX3f0d5aMARbkA=; b=pw6S3AZlbVa7eap5
	6S2AADOpFjK+v6bKCmzos7sjStWwnhV1vjBtEuJvjn3hSKHtQRp4iRkdsctINUvUJiVGO71ydY3a0
	lEVTz2hToyZsMI+WiSMT0lZyc/+3YgRbgzGSKW5o6kgXwgdWCmGKd/IPd8qpCq50aL4upGk56ABgV
	H3/vLLa88LQW6hVPMYlqDQFXVsZ8AM+ciKmQOxi+ETO5A1WcV9FCAmhlk1EuBSmZ9fo40zl90EslO
	Mn8OPeGZN+/z9szwRWX68uMg5cevHAWvI1xxDqZ+9uBh2RVkxhUrw1b8bKjWLY8Hw9nI5L9KYArnr
	+o4nmH2/pZVHJHqumQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1wpUXr-00000006qC2-05P7;
	Thu, 30 Jul 2026 17:27:47 +0000
Date: Thu, 30 Jul 2026 17:27:46 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/5] usb: typec: ps883x: fixes for older Thunderbolt 4 /
 USB4 docks
Message-ID: <amuJkjN1OH_-7a7g@gallifrey>
References: <20260718-ps883x-disable-usb4-v1-0-cec86d0b909e@oldschoolsolutions.biz>
 <al6-IyyWYRnEW4VC@venus>
 <al-dJjzorP-I4Yff@gallifrey>
 <al_0LjwmfW-cECnY@venus>
 <41222b67-19e5-4f74-b4aa-928d05db9675@oldschoolsolutions.biz>
 <amDi7e8fqqzCRlAc@venus>
 <47810646-3476-4f5b-b140-77b1934fd5b4@oldschoolsolutions.biz>
 <29de839d-707e-499d-a90b-36aaca0bebec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <29de839d-707e-499d-a90b-36aaca0bebec@oss.qualcomm.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.95+deb13-amd64 (x86_64)
X-Uptime: 17:26:13 up 24 days, 17:07,  2 users,  load average: 0.02, 0.03,
 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Konrad Dybcio (konrad.dybcio@oss.qualcomm.com) wrote:
> On 7/22/26 7:18 PM, Jens Glathe wrote:
> > Hi Sebastian,
> > 
> > On 7/22/26 18:03, Sebastian Reichel wrote:
> >> Hi,
> >>
> >> On Wed, Jul 22, 2026 at 10:38:34AM +0200, Jens Glathe wrote:
> >>> I understand, however I wouldn't want to nerf ps883x for the Hamoa
> >>> platform until the USB4 stack is complete. The issues you
> >>> currently run into is:
> >> That's exactly what this series is doing and not really a problem
> >> considering USB4 is not working anyways.
> > 
> > ...yet :) Alright, nerf patch it is. Question is how broad we need to specify. You have ps883x on all x1 (Hamoa and Purwa, like, Zenbook A14, IdeaCentre Mini X, HP Omnibook X14 fe1). So probably those compatibles: qcom,x1e80100, qcom,x1p42100, qcom,hamoa, qcom,purwa. Looks like a nerfing table :)
> > 
> > I will do this in v2.
> 
> On one hand, I would just say "don't be surprised connecting USB4
> hardware to hardware that doesn't [yet] support USB4 doesn't work"..
> 
> But if I were in your shoes, I'd prefer for my dock to work too..

Note that this isn't just something like a dock; but even a TB capable
C-C cable can't do usb networking over it between a pair of Snapdragon
laptops, while an older cable works fine.

> And perhaps this is a common problem. Do you have an x86 machine
> with TBT/USB4 where you could build a kernel with
> CONFIG_THUNDERBOLT=n? Does the platform firmware there handle this
> more gracefully, or do we need to make this a generic consideration?

I don't have an x86 Type-c machine, but someone did say aarch macs have
the problem as well.

Dave

> Konrad
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
