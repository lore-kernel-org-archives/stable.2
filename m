Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085881;
	b=0BuTtVCzncmIUXHU6LSanMxp/ENLg2Ccg8LoExXrPLifbM1QwFYY+v9Ups6LE53PxbMj
	 0SdtWwgl9VO1+IFBPzs9Dy8NNZEq8ILSrzHjmSsvbAGGucilzpH0FI9AVrsayYY9kfBIx
	 b2vR/UXYGtHOSzOimwseJfr/UOa8zvCfpyngJUwwfkV1OiCrrq1UwMZTBRFxLxQE0CunV
	 8/GL1S5gNqHPfmIYE9N+twdxPmwTnQGpy8cDl/yH6nmJWaq0XU+Ze9N+ZTPZs+y2YGSdU
	 ihrFZ2awastConr59RMt5YotJajD2U3nrwEjVeljFeh6Esicf6fU0sTiMUkE0xrMn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085881;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=54IG6ql9KgTDI9H+AnSJiw6y1w0PHnGKhrjTP0qwg2I=;
	b=Qmyh8ce4kzU1kQmoJQReyE5JFmt4PIQhZrnUxsnkrUQCRYnTRmbkpjJ3kbEnE+GG4cG/
	 G46YOoBjV4GR25ejPnuve2jux/+JSXkJoKhfbh3a7hJJS0+gvQXutdbyZr+ZOQzbVIRA1
	 kIAOG0zbDvlR1LTj7mbZ9neANr5czB0AREQuKLxdsJF9yxKZM3gGHZ9ly/ic7IPIKUMD5
	 uiOtvRpoZk4u/0UkpHQ5194YGLtwt00wXZ2D5OeHVn5cjA9h2yeukkf7TM+P9IQwEwQrJ
	 qIXcMOLvNO0+Ukb4oF2T+RajU8r5tDC3JztZyVTyGjsK7HEYrrFnVDork+TQXgzPkPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.206.16.166
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BF2606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65BF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz5t1793085873ta07ad9a8
X-QQ-Originating-IP: M6rwgO4/qz23Z7aPtn/QADvwEcfQrS0QznLdFNBSP2U=
Received: from smtpclient.apple ( [115.227.112.25])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Oct 2026 15:24:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17027930280472250786
EX-QQ-RecipientCnt: 14
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net v6] net: libwx: fix VF PM suspend/resume flow
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20261026151608.GA257209@horms.kernel.org>
Date: Tue, 27 Oct 2026 15:24:21 +0800
Cc: netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 hramamurthy@google.com,
 jacob.e.keller@intel.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <207CCD99-673A-4E63-8E53-05883953AEC9@net-swift.com>
References: <20261019060216.38458-1-mengyuanlou@net-swift.com>
 <179265975476.3135.4456951664798289210@kernel.org>
 <4ED66BF6-3475-4933-8BE3-8779745C2ABD@net-swift.com>
 <20261026151608.GA257209@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NN51gi9eLBwalcQqd58rXCqQJBRFioTBeNaSsRIkxU+KM0lf7CulkWgJ
	T6UuxICWjmDrA+heC0QmyLoQX4VTJoNrbI0QIsf2POVFQ1f89UbjWP+kzTlFEu36PARE5j6
	XH+vLqmcVoNHRgaTF2CBVmLAo8urPXeJ5DOF3wdgxenAg8GFuJKi9QRYl+671xJKuCrttRL
	C+Xi2jm7KzSG9QxgGGncaI5d9CiHvPlatgvWxv5/cTt/n4ON04LbF+5JcT0Z+Vke0oYilOr
	p4vXnO8RihUAES1rTEXWTrs9W3DQF68ghy6W1b91/z6wGO/OP28I3iCL3KG85EQNHSvlA5n
	X7LwI94tQFi3/rfJTlKZZbWyC693bv1yEWhtM0EqEyOZA2R9X4lR4WCEkDEeS3l7owHAPrs
	84yQed2IYDZFUSdl4AELWdRGUcobvCtHTnSavJUkEAxeBD2nlQYwyris9INXg0JN5/Hw/H7
	5r/7MSUYKFDylOfzMev4BzMug3rKcHriC2LH1xDntQtbCuCpGgJzbiuVmKAWhwycmy+mNzw
	m9BJSjrzH+PLo/G2K/KqtsGZbtt7VSTrwgHz0JcmNW/kKE4GcjN1+XlE+gvWJj58GMll8HV
	gom6AsZQLh8Kb5ozrJkEm/fKHpVvPkp+xs9S5Y0pY/zmT3toNm7syhj6dHGJesTqX1L+I9Z
	XaLH+8rB8MPc69/RpbkYTZGYxkWuajBqVEMJ3X4d+noj4ePJF3N1TEssrX1NQ6a+VUpLeFA
	dir2PhadP0CagkOQq3ZZxl0tqKikXwpwvZZyYlqyqUabl/P3QdDUsZ9Zsig9j2XgLocyw1o
	7PkLwecQ7YLzlPZc8ERD2rN+OZqMBofNMiCY89+UNtfuQkB8t+HutEaRfza/HKfipP/QCTK
	lcSpJx47CmCW3UdWA9p+h3WwafXfxIvqSb/ia+VTA1yLTSUGlCREFWl8FnhO+sPKgZ36M0p
	uXORmgS2CTKcMY1rL3jYoQ4QcRgLWIb2Sj3Ppw+LuQ+j96eHXJekqzHmn75SyYurCMAuJRx
	zK4M4jUwHl4GoqGxTNkhe7CF3QXg3ULkItqLT1uIWrnhCysAw7hzMNKGdrZTWLg09gJ+QMq
	A==
X-QQ-XMRINFO: MSVp+SPm3vtS89NDFrM59jH9/nKhHZFogA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B410=E6=9C=8826=E6=97=A5 23:16=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Oct 26, 2026 at 02:59:59PM +0800, mengyuanlou@net-swift.com =
wrote:
>>=20
>>=20
>>> 2026=E5=B9=B410=E6=9C=8822=E6=97=A5 =
17:02=EF=BC=8Cnetdev-bot+sashiko@kernel.org =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Thank you for your contribution! Sashiko AI review found 2 potential
>>> issue(s) to consider.
>>>=20
>>> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 1 (1)
>>>=20
>>> If you believe none of the issues are legitimate, please reply to =
each
>>> issue of Medium severity or higher and explain why the AI is wrong.
>>> If any of them are legitimate and you plan to respin, please let =
patchwork
>>> know by including "pw-bot: cr" as a separate line at the end of your =
reply
>>> (one such reply per series is enough).
>>>=20
>>> - [High] net: libwx: race between wxvf_remove() and =
wxvf_reopen_subtask()
>>> - [Low] The v5 changelog says "Schedule the reopen subtask =
immediately on
>>> resume; keep the service timer to retry if the PF is not ready."=E2=80=
=A6
>>>=20
>>> Pre-existing issues:
>>> - [High] This problem wasn't introduced by this patch, but the patch =
adds
>>> a new caller that depends on it.
>>> - [Low] This problem wasn't introduced by this patch, but VF =
teardown
>>> never frees the coherent interrupt-status block (wx->isb_mem) =
that=E2=80=A6
>>>=20
>>> --
>>>=20
>>> net: libwx: fix VF PM suspend/resume flow
>>>=20
>>> This patch reworks the shared txgbevf/ngbevf PM callbacks. Suspend =
now
>>> closes a running VF under RTNL and drains the service timer and work
>>> before disabling PCI. Resume re-enables PCI and hands the PF =
readiness
>>> check, VF reset, interrupt setup and reopen to the service task =
through
>>> a new WX_FLAG_NEED_REOPEN flag.
>>>=20
>>>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c =
b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>>>> index 26de78e9a69ef..e2271e8bffcda 100644
>>>> --- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>>>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
>>>=20
>>> [ ... ]
>>>=20
>>>> @@ -34,11 +48,20 @@ int wxvf_resume(struct device *dev_d)
>>>> {
>>>> struct pci_dev *pdev =3D to_pci_dev(dev_d);
>>>> struct wx *wx =3D pci_get_drvdata(pdev);
>>>> + int err;
>>>>=20
>>>> - pci_set_master(pdev);
>>>> - wx_init_interrupt_scheme(wx);
>>>> - netif_device_attach(wx->netdev);
>>>> + err =3D pci_enable_device_mem(pdev);
>>>> + if (err) {
>>>> + dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
>>>> + return err;
>>>> + }
>>>>=20
>>>> + clear_bit(WX_STATE_DISABLED, wx->state);
>>>> + pci_set_master(pdev);
>>>> + rtnl_lock();
>>>> + mod_timer(&wx->service_timer, jiffies + HZ);
>>>> + set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
>>>> + rtnl_unlock();
>>>> return 0;
>>>> }
>>>=20
>>> [Severity: Low]
>>> The v5 changelog says:
>>>=20
>>> Schedule the reopen subtask immediately on resume; keep the service
>>> timer to retry if the PF is not ready.
>>>=20
>>=20
>> This is removed in v6 after test.
>> And it was not mentioned in the changelog, which is a mistake.
>=20
> ...
>=20
>>> [Severity: High]
>>> Can wxvf_remove() race with a reopen that is still pending after
>>> resume?
>>>=20
>>> After wxvf_resume(), WX_FLAG_NEED_REOPEN is set, service_timer is
>>> armed, and WX_STATE_RES_FREED is still set from wxvf_suspend(). The =
VF
>>> can be unbound before wxvf_reopen_subtask() has completed. That =
window
>>> includes the first second after resume, and any period where the PF
>>> ping or wx_reset_vf() keeps failing and the subtask keeps retrying. =
In
>>> that case wxvf_remove() calls unregister_netdev() before it shuts =
down
>>> the timer or cancels the work.
>>>=20
>>> If the interface was up, unregister_netdev() reaches wxvf_close(),
>>> which returns early because WX_STATE_RES_FREED is already set. If =
the
>>> interface was down, wxvf_close() is not called at all. Either way,
>>> nothing clears WX_FLAG_NEED_REOPEN and nothing sets
>>> WX_STATE_DISABLED. WX_STATE_DISABLED is only set at the very end of
>>> wxvf_remove().
>>>=20
>>> Once unregister_netdev() drops RTNL, the timer can still queue the
>>> service task. wx_service_event_schedule() now lets it through =
because
>>> WX_FLAG_NEED_REOPEN is set. An already queued work can also run =
while
>>> wxvf_remove() waits in cancel_work_sync(). The guard in
>>> wxvf_reopen_subtask() passes, so it proceeds against a netdev that =
has
>>> already been unregistered:
>>>=20
>>> wxvf_reopen_subtask()
>>>   wx_mbx_write_and_read_reply()    /* PF mailbox traffic */
>>>   wx_reset_vf()                    /* VF reset */
>>>   wx_init_interrupt_scheme()
>>>     wx_set_interrupt_capability()  /* MSI-X vector allocation */
>>>     wx_alloc_q_vectors()           /* netif_napi_add() */
>>>   netif_device_attach()
>>>=20
>>> wx_clear_interrupt_scheme() later in wxvf_remove() frees those
>>> q_vectors again. Even so, adding NAPI instances to a netdev after
>>> unregister_netdevice() has torn it down does not look safe. Neither
>>> does resetting the VF over the mailbox and allocating IRQ vectors in
>>> the middle of remove.
>>>=20
>>> Should wxvf_remove() quiesce the service machinery before
>>> unregister_netdev()? For example, it could clear WX_FLAG_NEED_REOPEN =
or
>>> mark the device as being removed, then call timer_shutdown_sync() =
and
>>> cancel_work_sync() first. That is similar to how ixgbevf_remove() =
sets
>>> __IXGBEVF_REMOVING and cancels service_task before
>>> unregister_netdev(). Alternatively, should wxvf_reopen_subtask() =
refuse
>>> to run once the netdev is no longer registered?


The VF may resume before its PF, and the mailbox is not usable until the =
PF has resumed.
So resume only sets WX_FLAG_NEED_REOPEN and defers the reopen to =
wxvf_reopen_subtask(),
which retries over the mailbox until the PF is ready.

It's right about that WX_STATE_DISABLED is only set at the end of =
wxvf_remove(),
after unregister_netdev() has returned, so a pending (or newly queued) =
service
work could pass that guard and touch the netdev while it is being =
unregistered.
That window was real.=20

V7 will add check: the netdev to still be registered

 	rtnl_lock();
 	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags) ||
 	    test_bit(WX_STATE_DISABLED, wx->state) ||
 +++	    wx->netdev->reg_state !=3D NETREG_REGISTERED) {
 		rtnl_unlock();
 		return;
 	}
wxvf_reopen_subtask() and unregister_netdev() serialize on the same =
RTNL, and reg_state
leaves NETREG_REGISTERED before that lock is dropped.

Thanks,
Mengyuan



>>>=20
>>> [Severity: Low]
>>> This isn't a regression from this patch, but does the VF teardown =
path
>>> leak wx->isb_mem?
>>>=20
>>> wxvf_open()->wx_setup_resources()->wx_setup_isb_resources() =
allocates it
>>> with dma_alloc_coherent(), which is not devm-managed:
>>>=20
>>> wx->isb_mem =3D dma_alloc_coherent(&pdev->dev,
>>> sizeof(u32) * 4,
>>> &wx->isb_dma,
>>> GFP_KERNEL);
>>>=20
>>> wxvf_close() frees only the IRQs and the RX/TX rings. wxvf_remove() =
never
>>> calls wx_free_isb_resources(). That function is called only from
>>> ngbe_main.c and txgbe_main.c.
>>>=20
>>> wx_setup_isb_resources() returns early when isb_mem is already set, =
so
>>> repeated open/resume cycles do not leak more. Even so, the 16-byte
>>> coherent buffer seems to be left behind on every VF unbind if the
>>> interface was opened at least once.
>>>=20
>>> [ ... ]
>>>=20
>>>> +static void wxvf_reopen_subtask(struct wx *wx)
>>>> +{
>>>=20
>>> [ ... ]
>>>=20
>>>> + if (wx_init_interrupt_scheme(wx)) {
>>>> + dev_err(&wx->pdev->dev, "Failed to initialize interrupt =
scheme\n");
>>>> + goto hard_failure;
>>>> + }
>>>> +
>>>> + if (netif_running(wx->netdev)) {
>>>> + if (wxvf_open(wx->netdev))
>>>> + goto open_failed;
>>>> + }
>=20
> Hi Mengyuan,
>=20
> I apologise if I am missing something obvious.
> But could you respond to the High concern above?
>=20
> ...


